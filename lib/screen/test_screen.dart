import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/widget/time_bar.dart';

import '../model/question.dart';
import '../model/question_state.dart';
import '../provider/question_provider.dart';
import '../widget/answer_item.dart';
import '../widget/question_answer.dart';
import '../widget/question_list_to_test.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({
    super.key,
    required this.testNumber,
  });

  final int testNumber;

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  static const int totalTime = 1800; // 30 minutes = 1800 seconds
  final _pageController = PageController();

  late final List<Question> allQuestions;
  late final List<QuestionState> questionStates;
  late final int totalQuestion;
  late var notAnswered = 0;

  var isQuestionListVisible = true;
  var isShowPreviousButton = false;
  var isShowNextButton = true;
  Timer? timer;
  var timeLeft = totalTime;

  @override
  void initState() {
    super.initState();
    allQuestions = ref.read(questionProvider).sublist(0, 35);
    questionStates = List.generate(
        allQuestions.length,
        (index) => QuestionState(
            isSaved: allQuestions[index].isSaved,
            answerState: AnswerState.none));
    totalQuestion = allQuestions.length;
    notAnswered = totalQuestion;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft <= 0) {
        timer.cancel();
        onSubmit();
      }
      setState(() {
        timeLeft--;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void onQuestionSelected(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onPreviousClick() {
    print('Previous click');
    _pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void onNextClick() {
    print('Next click');
    _pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void onQuestionChange(int newQuestionIndex) {
    _pageController.animateToPage(newQuestionIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    Navigator.pop(context);
  }

  Future<bool> showDialogSubmit() async {
    bool isSubmit = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nộp bài'),
          content: Text(notAnswered > 0
              ? 'Bạn còn $notAnswered câu chưa trả lời, bạn có chắc chắn muốn nộp bài không?'
              : 'Bạn có chắc chắn muốn nộp bài không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                isSubmit = true;
              },
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
    return isSubmit;
  }

  Future<bool> showDialogTimeOut() async {
    bool isSubmit = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hết giờ'),
          content: const Text('Hết giờ làm bài!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                isSubmit = true;
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return isSubmit;
  }

  Future<void> onSubmit() async {
    print('Submit click');
    final isSubmit =
        timeLeft > 0 ? await showDialogSubmit() : await showDialogTimeOut();
    if (!isSubmit) return;
    timer?.cancel();

    int correctAnswer = 0;
    int wrongAnswer = 0;
    int notAnswer = 0;
    for (int i = 0; i < totalQuestion; i++) {
      if (questionStates[i].answerState == AnswerState.correct) {
        correctAnswer++;
      } else if (questionStates[i].answerState == AnswerState.wrong) {
        wrongAnswer++;
      } else {
        notAnswer++;
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kết quả'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Số câu đúng: $correctAnswer'),
              Text('Số câu sai: $wrongAnswer'),
              Text('Số câu chưa trả lời: $notAnswer'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Thi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: onSubmit,
            child: const Text(
              'Nộp bài',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: (totalQuestion == 0)
          ? const Center(
              child: Text(
              'Không có câu hỏi',
              style: TextStyle(
                fontSize: 14,
              ),
            ))
          : Stack(children: [
              // Question list and QuestionAnswer
              Column(
                children: [
                  TimeBar(
                    totalTime: totalTime,
                    timeLeft: timeLeft,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: totalQuestion,
                      itemBuilder: (context, index) {
                        return QuestionAnswer(
                          key: ValueKey(allQuestions[index].id),
                          currentQuestion: allQuestions[index],
                          currentQuestionIndex: index + 1,
                          totalQuestion: totalQuestion,
                          questionState: questionStates[index],
                          onStateChanged: (newState) {
                            setState(() {
                              questionStates[index] = newState;
                              // Update notAnswered
                              if (newState.answerState == AnswerState.none) {
                                notAnswered++;
                              } else {
                                notAnswered--;
                              }
                              print('Not answered: $notAnswered');
                            });
                          },
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          isShowPreviousButton = index != 0;
                          isShowNextButton = index != totalQuestion - 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Bottom navigation bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color(0xFFBDFFE7),
                  child: Column(
                    children: [
                      if (isQuestionListVisible)
                        QuestionListToTest(
                          onQuestionSelected: onQuestionSelected,
                          questionStatuses:
                              questionStates.map((e) => e.answerState).toList(),
                        ),
                      Container(
                        color: const Color(0xFFBDFFE7),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        child: Row(
                          children: [
                            if (isShowPreviousButton)
                              Expanded(
                                child: MaterialButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: onPreviousClick,
                                  splashColor: Colors.transparent,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.arrow_back_ios),
                                      Text(
                                        'Câu trước',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isQuestionListVisible =
                                        !isQuestionListVisible;
                                  });
                                },
                                icon: const Icon(Icons.list)),
                            if (isShowNextButton)
                              Expanded(
                                child: MaterialButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: onNextClick,
                                  splashColor: Colors.transparent,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Câu sau ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
    );
  }
}
