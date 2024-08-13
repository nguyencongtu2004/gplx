import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/widget/sign_item.dart';

import '../model/sign.dart';
import '../provider/sign_provider.dart';

class SignsScreen extends ConsumerStatefulWidget {
  const SignsScreen({super.key});

  @override
  ConsumerState<SignsScreen> createState() => _SignsScreenState();
}

class _SignsScreenState extends ConsumerState<SignsScreen> with SingleTickerProviderStateMixin {
  late final List<Sign> allSigns;
  late final List<List<Sign>> signsPerPage = List.filled(SignCategory.values.length, [], growable: true);
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    allSigns = ref.read(signProvider);

    for (final category in SignCategory.values) {
      signsPerPage[category.index] = allSigns.where((sign) => sign.category == category).toList();
      print('Có ${signsPerPage[category.index].length} biển báo thuộc loại $category');
    }

    // Xóa trang khác nếu không có biển báo
    if (signsPerPage[SignCategory.other.index].isEmpty) {
      signsPerPage.removeAt(SignCategory.other.index);
    }

    _tabController = TabController(length: signsPerPage.length, vsync: this);
  }

  void onSignTap(Sign sign) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
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
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text(
                'Biển báo giao thông',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pinned: true,
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  onPressed: () {
                    // todo
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                isScrollable: true,
                tabs: signsPerPage.map((signs) {
                  final String categoryName = _getSignCategoryName(signs.first.category);
                  return Tab(
                    child: Row(
                      children: [
                        const Icon(Icons.image, size: 42),
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
            return ListView.builder(
              addRepaintBoundaries: false,
              itemCount: signs.length,
              itemBuilder: (context, index) {
                final sign = signs[index];
                return SignItem(
                  sign: sign,
                  onTap: () {
                    onSignTap(sign);
                  },
                );
              },
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