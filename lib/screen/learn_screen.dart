import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/widget/question_answer.dart';

import '../provider/question_provider.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {

  var currentQuestion = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onPreviousClick() {
    print('Previous click');
    if (currentQuestion > 0) {
      currentQuestion -= 1;
    }
    setState(() {});
  }

  void onNextClick() {
    print('Next click');
    if (currentQuestion < ref.read(questionProvider).length - 1) {
      currentQuestion += 1;
    }
    setState(() {});
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
                children: <Widget>[
                  // Nội dung của BottomSheet
                  for (int i = 0; i < 20; i++)
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Thông tin $i'),
                    ),

                  // Thêm các mục khác tại đây
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
        body: QuestionAnswer(
          key: ValueKey(ref.read(questionProvider)[currentQuestion].id),
          currentQuestion: ref.read(questionProvider)[currentQuestion],
          totalQuestion: ref.read(questionProvider).length,
        ));
  }
}
