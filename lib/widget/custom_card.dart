import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.width,
    required this.minHeight,
    required this.title,
    this.description = '',
    required this.imageUrl,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.black,
    required this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.vibration = true,
    this.child,
  });

  final double width;
  final double minHeight;
  final String title;
  final String description;
  final String imageUrl;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final EdgeInsetsGeometry padding;
  final void Function() onTap;
  final Widget? child;
  final bool vibration;

  @override
  Widget build(BuildContext context) {
    Widget squareCard = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
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
        SizedBox(
          width: 100,
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

    Widget rectangleCard = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                width: 100,
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
        ),
        if (child != null) child!,
      ],
    );
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () async {
          if (vibration && (await Vibration.hasVibrator() ?? false)) {
            Vibration.vibrate(duration: 20);
          }
          onTap();
        },
        child: Container(
            width: width,
            //height: height, // this
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
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: (width > 250) ? rectangleCard : squareCard,
            )),
      ),
    );
  }
}
