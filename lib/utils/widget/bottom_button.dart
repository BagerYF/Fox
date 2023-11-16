import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/rounded_loading_button.dart';

class BottomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double fontSize;
  final String fontFamily;

  const BottomButton({
    Key? key,
    this.onTap,
    this.text = '',
    this.color = AppColors.WHITE,
    this.backgroundColor = AppColors.BLACK,
    this.margin = const EdgeInsets.fromLTRB(16, 16, 16, 16),
    this.fontSize = 16,
    this.fontFamily = AppTextStyle.BASEL_GROTESK_MEDIUM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width - 32,
        height: 40,
        margin: margin,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            )),
            textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: fontSize, fontFamily: fontFamily, color: color)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.grey[600];
              }
              return backgroundColor;
            }),
          ),
          onPressed: (onTap),
          child: Text(text),
        ));
  }
}

class BottomOutlineButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double fontSize;
  final String fontFamily;

  const BottomOutlineButton({
    Key? key,
    this.onTap,
    this.text = '',
    this.color = AppColors.BLACK,
    this.backgroundColor = AppColors.WHITE,
    this.margin = const EdgeInsets.fromLTRB(16, 16, 16, 16),
    this.fontSize = 16,
    this.fontFamily = AppTextStyle.BASEL_GROTESK_MEDIUM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width - 32,
        height: 40,
        margin: margin,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
                side: BorderSide(color: color))),
            textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: fontSize, fontFamily: fontFamily, color: color)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.grey[600];
              }
              return backgroundColor;
            }),
          ),
          onPressed: (onTap),
          child: Text(text),
        ));
  }
}

class BottomAnimationButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double fontSize;
  final String fontFamily;
  final RoundedLoadingButtonController controller;

  const BottomAnimationButton({
    Key? key,
    this.onTap,
    this.text = '',
    this.color = AppColors.WHITE,
    this.backgroundColor = AppColors.BLACK,
    this.margin = const EdgeInsets.fromLTRB(16, 16, 16, 24),
    this.fontSize = 16,
    this.fontFamily = AppTextStyle.BASEL_GROTESK_MEDIUM,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 32,
      margin: margin,
      child: RoundedLoadingButton(
        controller: controller,
        onPressed: onTap,
        width: Get.width - 32,
        height: 40,
        color: backgroundColor,
        borderRadius: 2,
        loaderSize: 18,
        resetAfterDuration: false,
        animateOnTap: false,
        resetDuration: const Duration(seconds: 30),
        successColor: backgroundColor,
        elevation: 0,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: color,
          ),
        ),
      ),
    );
  }
}
