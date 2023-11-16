// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';

enum PageIndicatorStyle {
  normal,
  wide,
  home,
}

class PageIndicator extends StatelessWidget {
  final pageIndex;
  final numberOfPage;
  final Color isSelectedColor = AppColors.GREY_424242;
  final Color notSelectedColor = AppColors.GREY_E0E0E0;
  final PageIndicatorStyle style;

  const PageIndicator(
      {super.key,
      required this.numberOfPage,
      required this.pageIndex,
      this.style = PageIndicatorStyle.normal});

  Widget _buildDot(bool isSelected) {
    double padding = 5.0;
    double width = 6.0;
    if (style == PageIndicatorStyle.wide) {
      padding = 5.0;
    } else if (style == PageIndicatorStyle.home) {
      width = 7.0;
      padding = 6.0;
    }

    return Container(
        width: width,
        height: width,
        margin: EdgeInsets.only(
          left: padding,
          right: padding,
        ),
        decoration: BoxDecoration(
            color: isSelected ? isSelectedColor : notSelectedColor,
            shape: BoxShape.circle));
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfPage; i++) {
      dots.add(_buildDot(pageIndex == i));
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: _buildDots());
  }
}
