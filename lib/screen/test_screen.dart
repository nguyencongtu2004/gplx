import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/model/test_answer_state.dart';
import 'package:gplx/provider/tests_provider.dart';
import 'package:gplx/widget/time_bar.dart';

import '../model/question.dart';
import '../model/question_state.dart';
import '../provider/license_class_provider.dart';
import '../provider/question_provider.dart';
import '../widget/answer_item.dart';
import '../widget/question_answer.dart';
import '../widget/question_list_to_test.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({
    super.key,
    required this.testId
  });

  final String testId;

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  final _pageController = PageController();

  late final List<Question> allQuestions;
  late final List<QuestionState> questionStates;
  late final int totalQuestion;
  late final List<int> questionId;

  late String licenseClass;
  late String testId;
  late int totalTime; // 30 minutes = 1800 seconds
  late int timeLeft;

  var notAnswered = 0;
  var isQuestionListVisible = true;
  var isShowPreviousButton = false;
  var isShowNextButton = true;
  var selectingPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    licenseClass = ref.read(licenseClassProvider);
    allQuestions = ref.read(questionProvider);
    testId = widget.testId;
    if (testId == '-1') {
      questionId = ref
          .read(testProvider.notifier)
          .generateTestSet(licenseClass);
      kTestRandomIds = questionId;
    }
    else {
      questionId = ref
        .read(testProvider)
        .firstWhere((test) => test.id == widget.testId)
        .questions;
    }

    questionStates = List.generate(
        questionId.length,
        (index) => QuestionState(
            isSaved: allQuestions[questionId[index] - 1].isSaved,
            answerState: AnswerState.none));
    totalQuestion = questionId.length;
    notAnswered = totalQuestion;
    totalTime = ref
            .read(testProvider.notifier)
            .getTestInformation(licenseClass)
            .timeLimit *
        60;
    timeLeft = totalTime;
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
          content: const Text('Đã hết giờ làm bài!'),
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

    markingAndUpdate();

    context.pushReplacement('/test-result/$testId');
  }

  void markingAndUpdate() {
    final correctAnswer = questionStates
        .where((element) => element.answerState == AnswerState.correct)
        .length;
    final wrongAnswer = questionStates
        .where((element) => element.answerState == AnswerState.wrong)
        .length;
    final notAnswer = questionStates
        .where((element) => element.answerState == AnswerState.notAnswered)
        .length;

    final testInfo =
        ref.read(testProvider.notifier).getTestInformation(licenseClass);
    final failingPointQuestionIds =
        ref.read(testProvider.notifier).getFailingPointQuestionIds();
    TestResult result;

    if (correctAnswer >= testInfo.minimumPassingScore) {
      result = TestResult.passed;
    } else {
      for (final id in questionId) {
        final index = questionId.indexOf(id);
        if (questionStates[index].answerState == AnswerState.wrong &&
            failingPointQuestionIds.contains(id)) {
          result = TestResult.failedWithFallingPoints;
          break;
        }
      }
      result = TestResult.failed;
    }

    final TestAnswerState testAnswerState = TestAnswerState(
      result: result,
      correctAnswers: correctAnswer,
      incorrectAnswers: wrongAnswer,
      notAnswered: notAnswer,
      questionStates: questionStates,
    );
    if (testId == '-1') {
      kTestRandomAnswerState = testAnswerState;
    } else {
      ref
          .read(testProvider.notifier)
          .updateTestAnswerState(testId, testAnswerState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Thi',
            style: Theme.of(context).textTheme.titleLarge,
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
                    child: PageView(
                      controller: _pageController,
                      children: [
                        for (final id in questionId)
                          QuestionAnswer(
                            padding: EdgeInsets.only(bottom: isQuestionListVisible ? 100 + 50 + 16 : 50 + 16),
                            key: ValueKey(id),
                            currentQuestion: allQuestions[id - 1],
                            currentQuestionIndex: questionId.indexOf(id) + 1,
                            totalQuestion: totalQuestion,
                            questionState:
                                questionStates[questionId.indexOf(id)],
                            onStateChanged: (newState) {
                              setState(() {
                                questionStates[questionId.indexOf(id)] =
                                    newState;
                                // Update notAnswered
                                if (newState.answerState ==
                                    AnswerState.none) {
                                  notAnswered++;
                                } else {
                                  notAnswered--;
                                }
                                print('Not answered: $notAnswered');
                              });
                            },
                          ),
                      ],
                      onPageChanged: (index) {
                        setState(() {
                          isShowPreviousButton = index != 0;
                          isShowNextButton = index != totalQuestion - 1;
                          selectingPage = index;
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFBDFFE7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (isQuestionListVisible)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: QuestionListToTest(
                            selectingPage: selectingPage,
                            onQuestionSelected: onQuestionSelected,
                            questionStatuses:
                                questionStates.map((e) => e.answerState).toList(),
                          ),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.arrow_back_ios, color: Colors.black),
                                      Text(
                                        'Câu trước',
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                          color: Colors.black,
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
                                icon: const Icon(Icons.list, color: Colors.black)),
                            if (isShowNextButton)
                              Expanded(
                                child: MaterialButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: onNextClick,
                                  splashColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Câu sau ',
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios, color: Colors.black)
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
