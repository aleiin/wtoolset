import 'package:flutter/material.dart';

class ExpandedEventItem extends StatelessWidget {
  const ExpandedEventItem({
    Key? key,
    this.topMargin = 0.0,
    this.leftMargin = 0.0,
    this.height = 0.0,
    this.isVisible = false,
    this.borderRadius = 0.0,
    this.title = '',
    this.date = '',
  }) : super(key: key);

  ///
  final double topMargin;

  ///
  final double leftMargin;

  ///
  final double height;

  ///
  final bool isVisible;

  ///
  final double borderRadius;

  ///
  final String title;

  ///
  final String date;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: height).add(const EdgeInsets.all(8)),
          child: contentView(),
        ),
      ),
    );
  }

  ///
  Widget contentView() {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '1 ticket',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Icon(
              Icons.place,
              color: Colors.grey.shade400,
              size: 16,
            ),
            Text(
              'Science Park 10 25A',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
