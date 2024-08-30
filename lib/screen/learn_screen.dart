import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  late ScrollController _scrollController;
  late final List<Question> allQuestions;
  late final List<QuestionState> questionStates;
  late final int totalQuestion;
  late final List<int> questionId;

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

    allQuestions = ref.read(questionProvider);
    switch (widget.chapter) {
      case -4:
        questionId = allQuestions
            .where((question) => question.questionStatus == QuestionStatus.wrong)
            .map((e) => e.id)
            .toList();
        break;
      case -3:
        questionId = allQuestions
            .where((question) => question.isHard)
            .map((e) => e.id)
            .toList();
        break;
      case -2:
        questionId = allQuestions
            .where((question) => question.isSaved)
            .map((e) => e.id)
            .toList();
        break;
      case -1:
        questionId = allQuestions.map((e) => e.id).toList();
        break;
      case 0:
        questionId = allQuestions
            .where((question) => question.isFailingPoint)
            .map((e) => e.id)
            .toList();
        break;
      default:
        questionId = allQuestions
            .where((question) => question.chapter == widget.chapter)
            .map((e) => e.id)
            .toList();
    }

    questionStates = List.generate(
        allQuestions.length,
        (index) => QuestionState(
            isSaved: allQuestions[index].isSaved,
            answerState: AnswerState.none));
    totalQuestion = questionId.length;
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
            for (final id in questionId)
              Column(
                children: [
                  QuestionItem(
                    key: ValueKey(id),
                    question: allQuestions[id - 1],
                    index: questionId.indexOf(id),
                    isSelecting: _pageController.page == questionId.indexOf(id),
                    onTap: () {
                      onQuestionChange(questionId.indexOf(id));
                      hideCustomTopSheet();
                    },
                  ),
                  if (id != totalQuestion - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                ],
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
      final double position = currentQuestionIndex * 80 - 80 * 2; // 80 là chiều cao của mỗi item
      if (currentQuestionIndex > 2) {
        _scrollController.jumpTo(position);
      }
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
            if (totalQuestion == 0 || isShowCustomTopSheet) return;
            if (details.velocity.pixelsPerSecond.dy > 50) {
              showCustomTopSheet(context);
            }
          },
          onTap: () {
            if (totalQuestion == 0 || isShowCustomTopSheet) return;
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
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: isShowCustomTopSheet
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: IconButton(
              tooltip: 'Danh sách câu hỏi',
              style: totalQuestion == 0 ? ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ) : null,
              onPressed: () {
                if (totalQuestion == 0) return;
                showCustomTopSheet(context);
              },
              icon: Icon(Icons.list,
                  color:
                      totalQuestion == 0 ? Colors.transparent : Colors.black),
            ),
            secondChild: IconButton(
              tooltip: 'Đóng',
              onPressed: () {
                hideCustomTopSheet();
              },
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ),
        ],
      ),
      body: totalQuestion == 0
          ? Center(
              child: const Text(
                'Không có câu hỏi nào',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, curve: Curves.easeInOut)
                  .slideY(),
            )
          : Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: [
                    for (final id in questionId)
                      QuestionAnswer(
                        key: ValueKey(id),
                        currentQuestion: allQuestions[id - 1],
                        currentQuestionIndex: questionId.indexOf(id) + 1,
                        totalQuestion: totalQuestion,
                        questionState: questionStates[questionId.indexOf(id)],
                        onStateChanged: (newState) {
                          setState(() {
                            questionStates[questionId.indexOf(id)] = newState;
                          });
                        }),
                  ],
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
                          const Spacer(),
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
                // Custom top sheet
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
