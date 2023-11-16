// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/network_image.dart';

import 'background_gesture.dart';

class ListItem extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final Color detailColor;
  EdgeInsets? padding;
  final EdgeInsets? margin;
  double? fontSize;
  final String fontFamily;
  final String detail;
  final String image;
  final bool svgImage;
  final bool hideArrow;

  ListItem({
    Key? key,
    this.onTap,
    this.text = '',
    this.color = AppColors.BLACK,
    this.detailColor = AppColors.BLACK,
    this.padding,
    this.margin = const EdgeInsets.only(left: 0.0, right: 0.0),
    this.fontSize,
    this.fontFamily = AppTextStyle.BASEL_GROTESK,
    this.detail = '',
    this.image = '',
    this.svgImage = false,
    this.hideArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<bool> isClicked = ValueNotifier(false);

    padding ??= const EdgeInsets.only(left: 16.0, right: 16.0);
    fontSize ??= 16;
    return BackgroundGesture(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: padding,
        margin: margin,
        decoration: const BoxDecoration(
          // color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: AppColors.GREY_EEEEEE),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (image.isNotEmpty)
              Container(
                width: 16,
                margin: const EdgeInsets.only(right: 10),
                child: svgImage == true
                    ? SvgPicture.network(image)
                    : AppCacheNetworkImage(
                        imageUrl: image,
                        boxFit: BoxFit.fitWidth,
                        width: 16,
                        height: 16,
                      ),
              ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  detail,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: detailColor,
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            if (hideArrow == false) Image.asset(LocalImages.asset('arrow'))
            // Icon(Icons.keyboard_arrow_right, color: AppColors.BLACK)
          ],
        ),
      ),
    );
  }
}

class ListItemSelect extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final Color enableColor;
  EdgeInsets? padding;
  double? fontSize;
  final String fontFamily;
  final bool selected;
  final String image;
  final bool enable;
  final bool svgImage;

  ListItemSelect({
    Key? key,
    this.onTap,
    this.text = '',
    this.color = AppColors.BLACK,
    this.enableColor = Colors.grey,
    this.padding,
    this.fontSize,
    this.fontFamily = AppTextStyle.BASEL_GROTESK,
    this.selected = false,
    this.image = '',
    this.enable = true,
    this.svgImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    padding ??= const EdgeInsets.only(left: 16.0, right: 16.0);
    fontSize ??= 16;
    return BackgroundGesture(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: padding,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: AppColors.GREY_EEEEEE))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (image.isNotEmpty)
              Container(
                width: 16,
                margin: const EdgeInsets.only(right: 10),
                child: svgImage == true
                    ? SvgPicture.network(image)
                    : AppCacheNetworkImage(
                        imageUrl: image,
                        boxFit: BoxFit.fitWidth,
                        width: 16,
                        height: 16,
                      ),
              ),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: enable ? color : enableColor,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                ),
              ),
            ),
            if (selected) Image.asset(LocalImages.asset('selected'))
          ],
        ),
      ),
    );
  }
}
