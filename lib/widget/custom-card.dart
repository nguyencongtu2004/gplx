import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.black,
    this.padding = const EdgeInsets.all(16),
    required this.onTap,
  });

  final double width;
  final double height;
  final String title;
  final String description;
  final String imageUrl;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final EdgeInsetsGeometry padding;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Widget squareCard = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );

    Widget rectangleCard = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: descriptionColor,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: width / 3.2,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ],
    );

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () async {
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate(duration: 30);
          }

          onTap();
        },
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: (width > 250) ? rectangleCard : squareCard,
        ),
      ),
    );
  }
}
