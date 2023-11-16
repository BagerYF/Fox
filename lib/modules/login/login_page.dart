import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/theme/styles/app_images.dart';
import 'package:fox/theme/styles/app_text_style.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/custom_input_item.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: '',
            showCloseButton: true,
          ),
          body: SafeArea(
            child: Form(
              key: controller.infoFormKey,
              onChanged: () {
                controller.update();
              },
              child: Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Shopify',
                        style: AppTextStyle.BlackBold30,
                      ),
                    ),
                  ),
                  if (!controller.isRegister) ...loginView(),
                  if (controller.isRegister) ...registerView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> loginView() {
    return [
      ...controller.infoInputList
          .sublist(1)
          .map((e) => CustomInputItem(
                inputItems: e,
              ))
          .toList(),
      const SizedBox(
        height: 34,
      ),
      BottomButton(
        text: 'Login',
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        onTap: () {
          controller.loginClick();
        },
      ),
      BottomOutlineButton(
        text: 'Create a new account',
        margin: const EdgeInsets.fromLTRB(16, 9, 16, 0),
        backgroundColor: Colors.white,
        onTap: () {
          controller.isRegister = true;
          controller.infoFormKey.currentState?.reset();
          controller.update();
        },
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(16, 24, 16, 33),
        child: const Text(
          'Continue as guest',
          style: AppTextStyle.Black12,
        ),
      ),
    ];
  }

  List<Widget> registerView() {
    return [
      ...controller.infoInputList
          .map((e) => CustomInputItem(
                inputItems: e,
              ))
          .toList(),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.emailSubscribe = !controller.emailSubscribe;
          controller.update();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 29),
          child: Row(
            children: <Widget>[
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(right: 8),
                child: controller.emailSubscribe
                    ? Image.asset(
                        LocalImages.asset('selected'),
                        width: 16,
                        height: 16,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        LocalImages.asset('check_n_'),
                        width: 16,
                        height: 16,
                        fit: BoxFit.fill,
                      ),
              ),
              const Text(
                'Subscribe to our newsletter',
                style: AppTextStyle.Black14,
              )
            ],
          ),
        ),
      ),
      BottomButton(
        text: 'Create account',
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        onTap: () {
          controller.registerClick();
        },
      ),
      BottomOutlineButton(
        text: 'Back to login',
        margin: const EdgeInsets.fromLTRB(16, 9, 16, 0),
        backgroundColor: Colors.white,
        onTap: () {
          controller.isRegister = false;
          controller.infoFormKey.currentState?.reset();
          controller.update();
        },
      ),
      Container(
        width: 200,
        margin: const EdgeInsets.fromLTRB(16, 24, 16, 33),
        child: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "By signing up you agree with our ",
                style: AppTextStyle.Black12,
              ),
              TextSpan(
                text: "Terms & Conditions",
                style: AppTextStyle.Grey12_9E9E9E,
              ),
              TextSpan(
                text: " and ",
                style: AppTextStyle.Black12,
              ),
              TextSpan(
                text: "Privacy Policy",
                style: AppTextStyle.Grey12_9E9E9E,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      )
    ];
  }
}
