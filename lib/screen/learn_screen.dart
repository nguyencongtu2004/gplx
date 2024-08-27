import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/question.dart';
import 'package:gplx/provider/topic_provider.dart';
import 'package:gplx/widget/question_answer.dart';
import 'package:gplx/widget/question_item.dart';

import '../model/question_state.dart';
import '../provider/question_provider.dart';
import '../widget/answer_item.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({
    super.key,
    required this.chapter,
  });

  final int chapter;

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final List<Question> allQuestions;
  late final List<QuestionState> questionStates;
  late final int totalQuestion;
  late ScrollController _scrollController;

  // UI variables
  var isShowPreviousButton = false;
  var isShowNextButton = true;
  var isShowCustomTopSheet = false;
  var currentQuestionIndex = 0;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    switch (widget.chapter) {
      case -4:
        allQuestions = ref
            .read(questionProvider)
            .where(
                (question) => question.questionStatus == QuestionStatus.wrong)
            .toList();
        break;
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
    questionStates = List.generate(
        allQuestions.length,
            (index) => QuestionState(
            isSaved: allQuestions[index].isSaved,
            answerState: AnswerState.none));
    totalQuestion = allQuestions.length;
  }

  void onPreviousClick() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void onNextClick() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void onQuestionChange(int newQuestionIndex) {
    _pageController.animateToPage(newQuestionIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() {
      isShowCustomTopSheet = false;
    });
  }

  Widget buildCustomTopSheet() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            for (int i = 0; i < totalQuestion; i++)
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  QuestionItem(
                    key: ValueKey(allQuestions[i].id),
                    question: allQuestions[i],
                    index: i,
                    isSelecting: _pageController.page == i,
                    onTap: () {
                      onQuestionChange(i);
                      hideCustomTopSheet();
                    },
                  ),
                  if (i != totalQuestion - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void showCustomTopSheet(BuildContext context) {
    setState(() {
      isShowCustomTopSheet = true;
    });

    // đăng ký một hàm callback (hàm gọi lại) sẽ được thực thi
    // sau khi khung hình hiện tại (frame) của widget tree đã được
    // render xong và các thay đổi đã được áp dụng.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double position = currentQuestionIndex * 80 - 80 * 2;
      _scrollController.jumpTo(position);
      _animationController.forward();
    });
  }


  void hideCustomTopSheet() {
    _animationController.reverse().then((_) {
      setState(() {
        isShowCustomTopSheet = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > 50) {
              showCustomTopSheet(context);
            }
          },
          onTap: () {
            if (totalQuestion == 0) return;
            showCustomTopSheet(context);
          },
          child: Center(
            child: Text(
              kTopic[widget.chapter] ?? 'Câu hỏi',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (totalQuestion == 0) return;
              if (isShowCustomTopSheet) {
                hideCustomTopSheet();
              } else {
                showCustomTopSheet(context);
              }
            },
            icon: Icon(Icons.list,
                color: totalQuestion == 0 ? Colors.transparent : Colors.black),
          ),
        ],
      ),
      body: totalQuestion == 0
          ? const Center(
        child: Text(
          'Không có câu hỏi nào',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      )
          : Stack(
        children: [
          PageView.builder(
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
                currentQuestionIndex = index;
                isShowPreviousButton = index != 0;
                isShowNextButton = index != totalQuestion - 1;
              });
            },
          ),
          // Bottom navigation
          if (totalQuestion != 0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
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
            ),
          if (isShowCustomTopSheet)
            FadeTransition(
              opacity: _fadeAnimation,
              child: ModalBarrier(
                color: Colors.black54,
                dismissible: true,
                onDismiss: hideCustomTopSheet,
              ),
            ),

          if (isShowCustomTopSheet) buildCustomTopSheet(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}