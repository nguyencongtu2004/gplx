import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/database/signs_table.dart';
import 'package:gplx/model/sign.dart';

class SignProvider extends StateNotifier<List<Sign>> {
  SignProvider() : super([]);

  Future<void> loadSigns() async {
    try {
      final signsData = await SignsTable.getAllSigns(); // Lấy tất cả dữ liệu từ bảng signs

      // Chuyển đổi dữ liệu thành danh sách các đối tượng Sign
      List<Sign> signs = signsData.map((data) => Sign.fromMap(data)).toList();

      // Cập nhật trạng thái của StateNotifier
      state = signs;
      print('Khởi tạo biển báo thành công từ DB');
    } catch (e) {
      // Xử lý lỗi (có thể log lỗi hoặc thông báo cho người dùng)
      print('Lỗi load biển báo từ DB: $e');
    }
  }
}

final signProvider =
    StateNotifierProvider<SignProvider, List<Sign>>(
        (ref) => SignProvider());