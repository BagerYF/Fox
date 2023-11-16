import 'package:flutter/material.dart';

class RefreshLoading extends StatelessWidget {
  const RefreshLoading(
      {Key? key,
      this.color = Colors.grey,
      this.width = 14,
      this.height = 14,
      this.strokeWidth = 2})
      : super(key: key);
  final Color color;
  final double width;
  final double height;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
