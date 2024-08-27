import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/provider/question_provider.dart';
import 'package:gplx/widget/sign_item.dart';
import 'package:vibration/vibration.dart';

import '../model/sign.dart';
import '../provider/settings_provider.dart';
import '../provider/sign_provider.dart';

class SignsScreen extends ConsumerStatefulWidget {
  const SignsScreen({super.key});

  // Hiển thị thông tin chi tiết của biển báo khi người dùng chọn vào biển báo
  static Future<void> onSignTap(BuildContext context, Sign sign,
      {required bool isVibration}) async {
    if (isVibration && (await Vibration.hasVibrator() ?? false)) {
      Vibration.vibrate(duration: 15);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 128),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                      maxWidth: 250,
                      minHeight: 150,
                      minWidth: 250,
                    ),
                    child: Image.asset(
                      'assets/data/images_of_sign/${sign.id}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    sign.id,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    sign.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    sign.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  ConsumerState<SignsScreen> createState() => _SignsScreenState();
}

class _SignsScreenState extends ConsumerState<SignsScreen>
    with SingleTickerProviderStateMixin {
  late final List<Sign> allSigns;
  late final List<Sign> usedSigns;

  late final List<List<Sign>> signsPerPage =
      List.filled(SignCategory.values.length, [], growable: true);
  late final TabController _tabController;
  var isShowUsedSigns = false;

  void updateFilteredSigns(List<Sign> signs) {
    for (final category in SignCategory.values) {
      if (category == SignCategory.other) {
        continue;
      }
      signsPerPage[category.index] =
          signs.where((sign) => sign.category == category).toList();
      print(
          'Có ${signsPerPage[category.index].length} biển báo thuộc loại $category');
    }
  }

  @override
  void initState() {
    super.initState();
    allSigns = ref.read(signProvider);
    usedSigns = ref.read(questionProvider).fold<List<Sign>>(
        [],
            (previousValue, element) => previousValue
          ..addAll(element.signId
              .map((signId) => allSigns.firstWhere((sign) => sign.id == signId))
              .toList())).toSet().toList(); // Lọc ra các biển báo không trùng lặp và chuyển về List

    updateFilteredSigns(allSigns);

    // Xóa trang khác nếu không có biển báo
    if (signsPerPage[SignCategory.other.index].isEmpty) {
      signsPerPage.removeAt(SignCategory.other.index);
    }

    _tabController = TabController(length: signsPerPage.length, vsync: this);
  }

  void onMoreButtonPressed() {
    showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(double.infinity, 80, 0, 0),
        items: [
          PopupMenuItem(
            child: CheckboxListTile(
              value: isShowUsedSigns,
              onChanged: (_) {
                setState(() {
                  isShowUsedSigns = !isShowUsedSigns;
                  if (isShowUsedSigns) {
                    updateFilteredSigns(usedSigns);
                  } else {
                    updateFilteredSigns(allSigns);
                  }
                });
                Navigator.of(context).pop();
              },
              title: const Text('Hiển thị biển báo trong câu hỏi'),
            ),
          ),
        ]);
  }

  String _getSignCategoryName(SignCategory category) {
    switch (category) {
      case SignCategory.prohibitory:
        return 'Cấm';
      case SignCategory.warning:
        return 'Nguy hiểm';
      case SignCategory.mandatory:
        return 'Hiệu lệnh';
      case SignCategory.indication:
        return 'Chỉ dẫn';
      case SignCategory.indicationOnHighway:
        return 'Chỉ dẫn trên cao tốc';
      case SignCategory.additional:
        return 'Biển phụ';
      case SignCategory.roadMarking:
        return 'Vạch kẻ đường';
      default:
        return 'Khác';
    }
  }

  String _getSignCategoryImage(SignCategory category) {
    switch (category) {
      case SignCategory.prohibitory:
        return 'P.102';
      case SignCategory.warning:
        return 'W.233';
      case SignCategory.mandatory:
        return 'R.303';
      case SignCategory.indication:
        return 'I.408';
      case SignCategory.indicationOnHighway:
        return 'IE.474';
      case SignCategory.additional:
        return 'S.502';
      case SignCategory.roadMarking:
        return 'V.1.1';
      default:
        return 'Khác';
    }
  }

  @override
  Widget build(BuildContext context) {

    final isVibration =
        ref.watch(settingsProvider.select((value) => value.isVibration));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Center(
                child: Text(
                  'Biển báo giao thông',
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
                IconButton(
                  onPressed: onMoreButtonPressed,
                  icon: const Icon(Icons.more_vert),
                )
              ],
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                isScrollable: true,
                tabs: signsPerPage.map((signs) {
                  final String categoryName =
                      _getSignCategoryName(signs.first.category);
                  final String categoryImage =
                      _getSignCategoryImage(signs.first.category);
                  return Tab(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/data/images_of_sign/$categoryImage.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(width: 8),
                        Text(categoryName),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: signsPerPage.map((signs) {
            // không dùng ListView để nó load trước hình ảnh
            return SingleChildScrollView(
              key: PageStorageKey<SignCategory>(signs.first.category),
              child: Column(
                children: signs.map((sign) {
                  return SignItem(
                    sign: sign,
                    size: 120,
                    onTap: () => SignsScreen.onSignTap(context, sign, isVibration: isVibration),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
