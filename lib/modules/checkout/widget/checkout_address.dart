import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/checkout/checkout_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/custom_input_item.dart';

class CheckoutAddress extends StatelessWidget {
  CheckoutAddress({Key? key}) : super(key: key);

  final CheckoutPageController controller = Get.find<CheckoutPageController>();

  @override
  Widget build(BuildContext context) {
    return addressFormView();
  }

  addressFormView() {
    return SingleChildScrollView(
      child: Form(
        key: controller.addressFormKey,
        onChanged: () {
          controller.update();
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: const Text(
                '*Required Fields',
                style: AppTextStyle.Black12,
              ),
            ),
            ...controller.addressInputList
                .sublist(0, 2)
                .map((e) => CustomInputItem(
                      inputItems: e,
                    ))
                .toList(),
            if (!controller.isLogin)
              ...controller.emailInputList
                  .map((e) => CustomInputItem(
                        inputItems: e,
                      ))
                  .toList(),
            if (controller.isLogin == false)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.emailSubscribe = !controller.emailSubscribe;
                  controller.update();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(right: 8),
                        child: controller.emailSubscribe
                            ? Image.asset(
                                LocalImages.asset('select_y'),
                                width: 16,
                                height: 16,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                LocalImages.asset('select_n'),
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
            ...controller.addressInputList
                .sublist(2, controller.addressInputList.length)
                .map((e) => CustomInputItem(
                      inputItems: e,
                    ))
                .toList(),
            if (controller.isLogin == false)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.rememberAddress = !controller.rememberAddress;
                  controller.update();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(right: 8),
                        child: controller.rememberAddress
                            ? Image.asset(
                                LocalImages.asset('select_y'),
                                width: 16,
                                height: 16,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                LocalImages.asset('select_n'),
                                width: 16,
                                height: 16,
                                fit: BoxFit.fill,
                              ),
                      ),
                      const Text(
                        'Save address for next purchase',
                        style: AppTextStyle.Black14,
                      )
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGiftItem(String discountCode) {
    return Container(
      height: 40,
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(width: 1.0, color: AppColors.GREY_E0E0E0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 7,
          ),
          Text(
            discountCode,
            style: AppTextStyle.Black14,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              controller.deleteDiscountCodeOrGiftCard();
            },
            child: Stack(
              children: [
                const SizedBox(
                  width: 28,
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7, top: 3),
                  child: Center(
                    child: Image.asset(
                      LocalImages.asset('gift_del'),
                      width: 16,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildGiftCardOrDiscoUntView() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 18,
            child: Text(
              'Add Code',
              style: AppTextStyle.Black12,
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: controller.giftCardFormKey,
                    child: TextFormField(
                      controller: controller.giftCardController,
                      maxLines: 1,
                      cursorColor: AppColors.BLACK,
                      style: AppTextStyle.Black16,
                      validator: (string) {
                        if (controller.giftCardErrorMessage != null) {
                          return '';
                        }
                        return null;
                      },
                      onChanged: (string) {
                        controller.showApply(string);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        fillColor: AppColors.WHITE,
                        filled: true,
                        hintStyle: AppTextStyle.Grey16_9E9E9E,
                        hintText: 'Gift card or discount code',
                        errorStyle: TextStyle(fontSize: 0.1),
                        contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.GREY_BDBDBD),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.GREY_BDBDBD),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.GREY_BDBDBD),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.GREY_BDBDBD),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    controller.applyDiscountCodeOrGiftCardToCart();
                  },
                  child: Container(
                    width: 74,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      border:
                          Border.all(color: AppColors.GREY_9E9E9E, width: 1),
                    ),
                    child: const Text(
                      'Apply',
                      style: AppTextStyle.BlackBold14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.giftCardErrorMessage != null &&
              controller.giftCardErrorMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 5),
              child: Text(
                controller.giftCardErrorMessage ?? '',
                style: AppTextStyle.Red16_CB0000,
              ),
            ),
        ],
      ),
    );
  }
}
