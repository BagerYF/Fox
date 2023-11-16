import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';

class ToastService {
  showErrorToast(String msg, {int duration = 10}) {
    Get.snackbar(
      '',
      '',
      duration: Duration(seconds: duration),
      titleText: GestureDetector(
        onTap: () {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 13),
              width: 22,
              height: 22,
              child: Image.asset(LocalImages.asset('warning')),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  msg,
                  style: AppTextStyle.White14,
                ),
              ),
            )
          ],
        ),
      ),
      messageText: const SizedBox(),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(top: 11, left: 13, bottom: 5, right: 13),
      colorText: Colors.white,
      backgroundColor: AppColors.RED_FF3B2F,
      borderRadius: 4,
    );
  }

  showToast(String msg) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      '',
      '',
      duration: const Duration(seconds: 3),
      titleText: GestureDetector(
        onTap: () {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  msg,
                  style: AppTextStyle.White14,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 0, left: 13),
                width: 22,
                height: 22,
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.WHITE,
                )),
          ],
        ),
      ),
      messageText: const SizedBox(),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(top: 11, left: 13, bottom: 5, right: 13),
      colorText: Colors.white,
      backgroundColor: AppColors.GREY_212121,
      borderRadius: 4,
    );
  }

  showLoginToast() {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      '',
      '',
      duration: const Duration(seconds: 10),
      titleText: GestureDetector(
        onTap: () {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "Session expired. Please ",
                      style: AppTextStyle.White14,
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (Get.isSnackbarOpen) {
                                Get.closeCurrentSnackbar();
                              }
                            },
                            child: const Text(
                              "sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "BaselGrotesk",
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: " again",
                          style: AppTextStyle.White14,
                        ),
                      ]),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 13, left: 13),
                width: 22,
                height: 22,
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.WHITE,
                )),
          ],
        ),
      ),
      messageText: const SizedBox(),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(top: 11, left: 13, bottom: 5, right: 13),
      colorText: Colors.white,
      backgroundColor: AppColors.GREY_212121,
      borderRadius: 4,
    );
  }
}
