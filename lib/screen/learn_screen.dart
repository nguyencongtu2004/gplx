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
  final _scrollController = ScrollController();
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
            .where(
                (question) => question.questionStatus == QuestionStatus.wrong)
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
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        questionId = allQuestions
            .where((question) => question.chapter == widget.chapter)
            .map((e) => e.id)
            .toList();
        break;
      default:
        throw Exception('Chương ${widget.chapter} không hợp lệ');
    }

    questionStates = List.generate(
        questionId.length,
        (index) => QuestionState(
            isSaved: allQuestions[questionId[index] - 1].isSaved,
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
        decoration:  BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
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
      final double position =
          currentQuestionIndex * 80 - 80 * 2; // 80 là chiều cao của mỗi item
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
              style: Theme.of(context).textTheme.titleLarge,
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
              style: totalQuestion == 0
                  ? ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    )
                  : null,
              onPressed: () {
                if (totalQuestion == 0) return;
                showCustomTopSheet(context);
              },
              icon: Icon(Icons.list,
                  color:
                      totalQuestion == 0 ? Colors.transparent : null),
            ),
            secondChild: IconButton(
              tooltip: 'Đóng',
              onPressed: () {
                hideCustomTopSheet();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: totalQuestion == 0
          ? Center(
              child: Text(
                'Không có câu hỏi nào',
                style: Theme.of(context).textTheme.bodyMedium,
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
                          padding: const EdgeInsets.only(bottom: 50 + 16),
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
                          const Spacer(),
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
                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                  ),
                // Custom top sheet
                if (isShowCustomTopSheet) ...[
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ModalBarrier(
                      color: Colors.black54,
                      dismissible: true,
                      onDismiss: hideCustomTopSheet,
                    ),
                  ),
                  buildCustomTopSheet()
                ]
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
