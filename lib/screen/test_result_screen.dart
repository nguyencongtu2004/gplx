import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/test_answer_state.dart';
import 'package:gplx/widget/answer_item.dart';
import 'package:gplx/widget/question_answer.dart';
import 'package:gplx/widget/test_result_item.dart';

import '../model/question.dart';
import '../model/question_state.dart';
import '../provider/question_provider.dart';
import '../provider/tests_provider.dart';
import '../widget/question_item.dart';

class TestResultScreen extends ConsumerStatefulWidget {
  const TestResultScreen({
    super.key,
    required this.testId,
  });

  final String testId;

  @override
  ConsumerState<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends ConsumerState<TestResultScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollController = ScrollController();

  late final List<Question> allQuestions;
  late final List<QuestionState> questionStates;
  late final int totalQuestion;
  late final List<int> questionId;
  late final List<List<int>> questionIdPerPage;
  late final TestResult testResult;

  var isShowCustomTopSheet = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _resultItemController;
  late Animation<Offset> _resultItemSlideAnimation;

  final tabHeaders = [
    'Tất cả',
    'Câu đúng',
    'Câu sai',
    'Chưa trả lời',
  ];

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

    _resultItemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _resultItemSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _resultItemController,
      curve: Curves.easeInOut,
    ));

    _tabController = TabController(length: tabHeaders.length, vsync: this);

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset <= 50) {
        // Hiện TestResultItem
        _resultItemController.reverse();
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        // Kéo lên - Ẩn TestResultItem
        _resultItemController.forward();
      }
    });

    allQuestions = ref.read(questionProvider);
    questionId = ref
        .read(testProvider)
        .firstWhere((test) => test.id == widget.testId)
        .questions;
    questionStates = ref
        .read(testProvider)
        .firstWhere((test) => test.id == widget.testId)
        .testAnswerState
        .questionStates!;
    questionIdPerPage = [
      questionId,
      [
        for (final state in questionStates)
          if (state.answerState == AnswerState.correct)
            questionId[questionStates.indexOf(state)]
      ],
      [
        for (final state in questionStates)
          if (state.answerState == AnswerState.wrong)
            questionId[questionStates.indexOf(state)]
      ],
      [
        for (final state in questionStates)
          if (state.answerState == AnswerState.notAnswered)
            questionId[questionStates.indexOf(state)]
      ],
    ];
    totalQuestion = questionId.length;

    testResult = ref
        .read(testProvider)
        .firstWhere((test) => test.id == widget.testId)
        .testAnswerState
        .result;

    if (testResult != TestResult.passed) {
      _tabController.animateTo(2);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
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
                    isSelecting: false,
                    // todo: fix khi chọn câu hỏi từ danh sách
                    onTap: () {
                      // todo: chuyển câu hỏi khi chọn từ danh sách
                      //onQuestionChange(questionId.indexOf(id));
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
      // todo: fix vị trí hiển thị danh sách câu hỏi
      /*final double position =
          currentQuestionIndex * 80 - 80 * 2; // 80 là chiều cao của mỗi item
      if (currentQuestionIndex > 2) {
        _scrollController.jumpTo(position);
      }*/
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
        title: const Center(
          child: Text(
            'Kết quả thi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
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
        bottom: TabBar(
          tabAlignment: TabAlignment.center,
          controller: _tabController,
          isScrollable: true,
          tabs: tabHeaders.map((tab) {
            return Tab(
              child: Text(tab),
            );
          }).toList(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _resultItemSlideAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: _resultItemSlideAnimation,
                  child: child,
                );
              },
              child: TestResultItem(
                testResult: testResult,
              ),
            ),
          ),
          Positioned.fill(
            child: TabBarView(
              // todo: thử thay bằng PageView xem đỡ lag không
              controller: _tabController,
              children: questionIdPerPage.map((tab) {
                if (tab.isEmpty) {
                  return const Center(child: Text('Không có câu hỏi'));
                } else {
                  return SingleChildScrollView(
                    controller: _scrollController,
                        child: Column(
                        children: [
                          for (final id in tab) ...[
                            QuestionAnswer(
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
                                });
                              },
                              readOnly: true,
                            ),
                            const Divider(thickness: 8),
                          ]
                        ],
                      ));
                }
              }).toList(),
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
}
