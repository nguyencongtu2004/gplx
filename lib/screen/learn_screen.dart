import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/question.dart';
import 'package:gplx/widget/question_answer.dart';
import 'package:gplx/widget/question_item.dart';

import '../provider/question_provider.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({
    super.key,
    required this.chapter,
  });

  final int chapter;

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  var currentQuestionIndex = 0;
  final _pageController = PageController();
  late final List<Question> allQuestions;
  late final int totalQuestion;
  late final int lastQuestionIndex;

  @override
  void initState() {
    super.initState();

    switch (widget.chapter) {
      case -3:
        allQuestions = ref
            .read(questionProvider)
            .where((question) => question.isHard)
            .toList();
        break;
      case -2:
        allQuestions = ref
            .read(questionProvider)
            .where((question) => question.isSaved)
            .toList();
        break;
      case -1:
        allQuestions = ref.read(questionProvider);
        break;
      case 0:
        allQuestions = ref
            .read(questionProvider)
            .where((question) => question.isFailingPoint)
            .toList();
        break;
      default:
        allQuestions = ref
            .read(questionProvider)
            .where((question) => question.chapter == widget.chapter)
            .toList();
    }
    totalQuestion = allQuestions.length;
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

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép điều chỉnh chiều cao
      backgroundColor: Colors.transparent, // Đặt nền trong suốt
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          // Chiều cao ban đầu là 50%
          maxChildSize: 0.8,
          // Chiều cao tối đa là 80%
          minChildSize: 0.5,
          // Chiều cao tối thiểu là 50%
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Danh sách câu hỏi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Nội dung của BottomSheet
                  for (int i = 0; i < totalQuestion; i++) ...[
                    QuestionItem(
                      question: allQuestions[i],
                      index: i,
                      onTap: () {
                        onQuestionChange(i);
                      },
                    ),
                    if (i != totalQuestion - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Câu hỏi điểm liệt',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showCustomBottomSheet(context);
              },
              icon: const Icon(Icons.list),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            color: const Color(0xFFBDFFE7),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: [
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
        body: PageView(controller: _pageController, children: [
          for (int i = 0; i < totalQuestion; i++)
            QuestionAnswer(
              key: ValueKey(allQuestions[i].id),
              currentQuestion: allQuestions[i],
              currentQuestionIndex: i + 1,
              totalQuestion: totalQuestion,
            )
        ]));
  }
}
