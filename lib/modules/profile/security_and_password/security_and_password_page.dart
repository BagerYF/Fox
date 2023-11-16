import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/profile/security_and_password/security_and_password_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/custom_input_item.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class SecurityAndPasswordPage extends StatelessWidget {
  SecurityAndPasswordPage({Key? key}) : super(key: key);

  final SecurityAndPasswordPageController controller =
      Get.put(SecurityAndPasswordPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Security and Password",
      ),
      body: GetBuilder<SecurityAndPasswordPageController>(
        builder: (_) {
          return SafeArea(
            child: Form(
              key: controller.helpFormKey,
              onChanged: () {
                controller.update();
              },
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: NoScrollBehavior(),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 22,
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 16),
                            child: const Text(
                              'Update Password',
                              style: AppTextStyle.Black16,
                            ),
                          ),
                          ...controller.helpInputList
                              .map((e) => CustomInputItem(
                                    inputItems: e,
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                  if (!controller.showKeyboard)
                    BottomAnimationButton(
                      controller: controller.btnController,
                      text: controller.txt,
                      onTap: () {
                        controller.sendClick();
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
