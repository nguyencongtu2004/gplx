import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gplx/screen/learn_screen.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Mẹo làm bài',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.list,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      body: Markdown(
        padding: const EdgeInsets.all(16),
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          h1Padding: const EdgeInsets.only(top: 16),
          tableColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width / 2.5),
        ),
        data: _data,
      ).animate().fadeIn(duration: 300.ms),
    );
  }

  static const _data = '''
# **Tốc độ tối đa cho phép**

|  |  | Ô tô kéo rơ moóc, trộn bê tông | Mô tô, đầu kéo, ô tô buýt | Ô tô trên 30 chỗ, tải trọng trên 3,5 tấn | Ô tô ĐẾN 30 chỗ, tải trọng nhỏ hơn 3,5 tấn | Xe máy chuyên dụng, xe gắn máy |
| --- | --- | --- | --- | --- | --- | --- |
| Khu vực đông dân cư: | Đường đôi, đường 1 chiều 2 làn xe trở lên: | 60 km/h | 60 km/h | 60 km/h | 60 km/h | 40 km/h |
|  | Đường hai chiều, đường 1 chiều có 1 làn xe: | 50 km/h | 50 km/h | 50 km/h | 50 km/h | 40 km/h |
| Ngoài khu vực đông dân cư: | Đường đôi, đường 1 chiều 2 làn xe trở lên: | 60 km/h | 70 km/h | 80 km/h | 90 km/h | 40 km/h |
|  | Đường hai chiều, đường 1 chiều có 1 làn xe: | 50 km/h | 60 km/h | 70 km/h | 80 km/h | 40 km/h |

### 1. Khu vực đông dân cư:

1. Đường đôi, đường 1 chiều 2 làn xe trở lên: 
    - Toàn bộ phương tiện: 60 km/h
2. Đường hai chiều, đường 1 chiều có 1 làn xe: 
    - Toàn bộ phương tiện: 50 km/h

### 2. Ngoài khu vực đông dân cư:

1. Đường đôi, đường 1 chiều 2 làn xe trở lên:
    - Ô tô kéo rơ moóc, trộn bê tông: 60 km/h
    - Mô tô, đầu kéo, ô tô buýt: 70 km/h
    - Ô tô trên 30 chỗ, tải trọng **TRÊN** 3,5 tấn: 80 km/h
    - Ô tô **ĐẾN** 30 chỗ, tải trọng nhỏ hơn 3,5 tấn: 90 km/h
2. Đường hai chiều, đường 1 chiều có 1 làn xe:
    - Ô tô kéo rơ moóc, trộn bê tông: 50 km/h
    - Mô tô, đầu kéo, ô tô buýt: 60 km/h
    - Ô tô trên 30 chỗ, tải trọng **TRÊN** 3,5 tấn: 70 km/h
    - Ô tô **ĐẾN** 30 chỗ, tải trọng nhỏ hơn 3,5 tấn: 80 km/h

### Xe máy chuyên dụng, xe gắn máy: luôn luôn 40 km/h

# **Khoảng cách an toàn tối thiểu**

- Vận tốc 60 km/h: 35 mét.
- Vận tốc 60-80 km/h: 55 mét.
- Vận tốc 80-100 km/h: 70 mét.
- Vận tốc 100-120 km/h: 100 mét.

# **Sa hình, thứ tự ưu tiên**

### Thứ tự ưu tiên với xe ưu tiên

1. Xe cứu hoả
2. Xe quân sự
3. Xe công an
4. Xe cứu thương
5. Xe hộ đê, xe đi làm nhiệm vụ khẩn cấp
6. Đoàn xe tang

### Thứ tự ưu tiên: Nhất chớm, nhì ưu, tam đường, tứ hướng

- Nhất chớm: Xe nào chớm tới vạch trước thì được đi trước
- Nhì ưu: Xe ưu tiên được đi trước
- Tam đường: Xe ở đường chính, đường ưu tiên
- Tứ hướng: Thứ tự hướng: Bên phải trống - Rẽ phải - Đi thẳng - Rẽ trái
- Thứ tự ưu tiên không vòng xuyến: Xe vào ngã ba, ngã tư trước - Xe ưu tiên - Đường ưu tiên - Đường cùng cấp theo thứ tự bên phải trống - rẽ phải - đi thẳng - rẽ trái.
- Giao nhau cùng cấp có vòng xuyến: Chưa vào vòng xuyến thì ưu tiên xe bên phải; đã vào vòng xuyến ưu tiên xe từ bên trái tới.
- Xe xuống dốc phải nhường đường cho xe đang lên dốc.

# **Khái niệm và quy tắc**

- Tất cả các câu có đáp án bị nghiêm cấm, không cho phép hoặc không được phép thì chọn đáp án đó.
- Các câu có rượu bia, nồng độ cồn, chọn NGHIÊM CẤM
- Tốc độ chậm đi về bên phải.
- Xe thô sơ phải đi làn đường nên phải trong cùng.
- Chỉ sử dụng còi từ 5 giờ sáng đến 22 giờ tối.
- Trong đô thị sử dụng đèn chiếu gần (đèn cốt)
- Xe mô tô không được kéo xe khác.
- Chuyển làn đường phải có tín hiệu báo trước.
- Xe thiết kế nhỏ hơn 70km/h không được vào cao tốc.
- Trên cao tốc chỉ được dừng xe, đỗ xe ở nơi quy định.
- Trong hầm chỉ được dừng xe, đỗ xe ở nơi quy định.
- Trọng lượng xe kéo rơ moóc phải lớn hơn rơ moóc.
- Kéo xe không hệ thống hãm phải dùng thanh nối cứng.
- Dừng xe, đỗ xe cách lề đường, hè phố không quá 0.25 mét.
- Dừng xe, đỗ xe trên đường hẹp cách xe khác 20 mét.
- Nhường đường cho xe ưu tiên có tín hiệu còi, cờ, đèn.
- Điểm giao cắt đường sắt thì ưu tiên đường sắt.

# **Nghiệp vụ vận tải**

- Không lái xe liên tục quá 4 giờ
- Thời gian lái xe tối đa 1 ngày: 10 giờ
- Người kinh doanh vận tải không được tự ý thay đổi vị trí đón trả khách
- Vận chuyển hàng nguy hiểm phải có giấy phép
- Hàng cấm không được vận chuyển

# **Cấu tạo và sửa chữa**

- Yêu cầu của kính chắn gió, chọn “Loại kính an toàn".
- Âm lượng của còi là từ 90dB đến 115 dB.
- Động cơ diesel không nổ do nhiên liệu lẫn tạp chất.
- Dây đai an toàn có cơ cấu hãm giữ chặt dây khi giật dây đột ngột.
- Động cơ 4 kỳ thì pít tông thực hiện 4 hành trình.
- Hệ thống bôi trơn giảm ma sát.
- Động cơ ô tô biến nhiệt năng thành cơ năng.
- Hệ thống truyền lực truyền mô men quay từ động cơ tới bánh xe.
- Ly hợp (côn) truyền hoặc ngắt truyền động từ động cơ đến hộp số.
- Hộp số ô tô đảm bảo chuyển động lùi.
- Hệ thống lái dùng để thay đổi hướng.
- Hệ thống phanh giúp giảm tốc độ.
- Ắc quy để tích trữ điện năng.
- Khởi động xe tự động phải đạp phanh.

# **Kỹ thuật lái xe**

- Xe mô tô xuống dốc dài cần sử dụng cả phanh trước và phanh sau để giảm tốc độ.
- Khởi hành xe ô tô số tự động cần đạp phanh chân hết hành trình.
- Thực hiện phanh tay cần phải bóp khóa hãm đẩy cần phanh tay về phía trước.
- Khởi hành ô tô sử dụng hộp số đạp côn hết hành trình.
- Thực hiện quay đầu xe với tốc độ thấp.
- Lái xe ô tô qua đường sắt không rào chắn thì cách 5 mét hạ kính cửa, tắt âm thanh, quan sát.
- Mở cửa xe thì quan sát rồi mới mở **hé** cánh cửa.

# **Các hạng giấy phép lái xe**

### Mô tô

- A1 mô tô dưới 175 cm3 và xe 3 bánh của người khuyết tật
- A2 mô tô 175 cm3 trở lên
- A3 xe mô tô 3 bánh

### Ô tô

- B1 có GPLX loại xe tự động và cả loại xe số sàn. Kích cỡ xe tương tự B2
- B1 KHÔNG hành nghề lái xe
- B2 chở ĐẾN 9 chỗ ngồi, máy kéo có tải trọng DƯỚI 3.500 kg.
- C ĐẾN 9 chỗ ngồi, máy kéo tải trọng TRÊN 3.500kg.
- D chở ĐẾN 30 người, máy kéo tải trọng TRÊN 3.500kg.
- E chở TRÊN 30 người, máy kéo tải trọng TRÊN 3.500kg.
- FC: C + kéo (ô tô đầu kéo, kéo sơ mi rơ moóc)
- FE: E + chở khách nối toa

# **Các câu hỏi về tuổi**

| Loại xe | Tuổi |
| --- | --- |
| Gắn máy | 16 |
| Mô tô + B1 + B2 | 18 |
| C, FB | 21 |
| D, FC | 24 |
| E, FD | 27 |
- Tuổi tối đa hạng E: nam 55, nữ 50
- Tuổi lấy bằng lái xe (cách nhau 3 tuổi)
- Gắn máy: 16 tuổi (dưới 50cm3)
- Mô tô + B1 + B2: 18 tuổi
- C, FB: 21 tuổi
- D, FC: 24 tuổi
- E, FD: 27 tuổi

# **Niên hạn sử dụng phương tiện (tính từ năm sản xuất)**

- Ô tô tải: **25 năm**
- Ô tô chở người trên 9 chỗ: **20 năm**

# **Hiệu lệnh người điều khiển giao thông**

- Hiệu lệnh của người điều khiển có độ ưu tiên cao hơn đèn hoặc biển báo
- **Tay giơ thẳng đứng:** Người tham giao thông ở ở tất cả các hướng đều phải dừng lại
- **1 tay hoặc 2 tay giang ngang:** Phía trước và phía sau dừng lại, bên trái bên phải được phép đi

# **Tàu hỏa**

- Đứng cách ray đường sắt **5m.**
- Phương tiện đường sắt LUÔN LUÔN có độ ưu tiên cao nhất
- Không được dừng, đỗ, quay đầu tại điểm giao cùng cấp với đường sắt
  ''';
}
