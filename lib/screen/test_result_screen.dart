import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  var isShowCustomTopSheet = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final tabsContent = [
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
    totalQuestion = questionId.length;

    _tabController = TabController(length: tabsContent.length, vsync: this);
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
    final testResult =
        ref.watch(testProvider).firstWhere((test) => test.id == widget.testId);

    Widget content = Center(
      child: Column(
        children: [
          Text('Test Result Screen, Id: ${widget.testId}'),
          Text('Test Result: ${testResult.testAnswerState.result}'),
          Text('Test AnswerState: ${testResult.testAnswerState.toMap()}'),
        ],
      ),
    );

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
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
                pinned: true,
                floating: true,
                snap: true,
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
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                            )
                          : null,
                      onPressed: () {
                        if (totalQuestion == 0) return;
                        showCustomTopSheet(context);
                      },
                      icon: Icon(Icons.list,
                          color: totalQuestion == 0
                              ? Colors.transparent
                              : Colors.black),
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
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: tabsContent.map((tab) {
                    return Tab(
                      child: Text(tab),
                    );
                  }).toList(),
                ),
              ),
            ];
          },
          body: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: tabsContent.map((_) => content).toList(),
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
          )),
    );
  }
}
