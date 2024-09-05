import 'package:flutter/material.dart';
import 'package:gplx/model/sign.dart';

class SignItem extends StatelessWidget {
  const SignItem({
    super.key,
    required this.sign,
    required this.onTap,
    required this.imageSize,
  });

  final Sign sign;
  final void Function() onTap;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Hiển thị ảnh biển báo
            Image.asset(
              'assets/data/images_of_sign/${sign.id}.png',
              width: imageSize,
              height: imageSize,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hiển thị mã biển báo
                  Text(
                    sign.id,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  // Hiển thị tên biển báo
                  Text(
                    sign.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Hiển thị mô tả biển báo
                  Text(
                    sign.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}