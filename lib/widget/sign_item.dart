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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  // Hiển thị tên biển báo
                  Text(
                    sign.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Hiển thị mô tả biển báo
                  Text(
                    sign.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
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