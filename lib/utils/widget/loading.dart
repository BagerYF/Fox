import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:fox/theme/styles/styles.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.showText = true, this.hasBar = true})
      : super(key: key);
  final bool? showText;
  final bool? hasBar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hasBar!
          ? Get.height - Get.bottomBarHeight - Get.statusBarHeight
          : Get.height,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.BLACK,
          ),
        ),
      ),
    );
    /*Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.BLACK,
            ),
          ),
          if (showText == true)
            Container(
              margin: EdgeInsets.only(top: 13),
              height: 22,
              child: Text(
                'loading',
                style: AppTextStyle.Black16,
              ),
            ),
        ],
      ),
    );*/
  }
}
