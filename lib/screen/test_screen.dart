import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  late final List<Question> allQuestions;
  late final List<QuestionState> questionStates;
  late final int totalQuestion;
  late final int lastQuestionIndex;

  bool isQuestionListVisible = true;

  var isShowPreviousButton = false;
  var isShowNextButton = true;

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

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // Scrolling down, hide the QuestionListToTest
      if (isQuestionListVisible) {
        setState(() {
          isQuestionListVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Scrolling up, show the QuestionListToTest
      if (!isQuestionListVisible) {
        setState(() {
          isQuestionListVisible = true;
        });
      }
    }
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
            onPressed: () {},
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
      bottomNavigationBar: totalQuestion == 0
          ? null
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              color: Colors.red,
              height: 15,
              child: const Row(
                children: [
                  Text('time left'),
                ],
              )),
          BottomAppBar(
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
                        )),
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
                        )),
                ],
              )),
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
          : Column(
        children: [
          if (isQuestionListVisible)
            QuestionListToTest(
              onQuestionSelected: onQuestionSelected,
              questionStatuses:
              questionStates.map((e) => e.answerState).toList(),
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
    );
  }
}