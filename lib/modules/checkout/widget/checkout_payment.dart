import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/modules/checkout/checkout_page_controller.dart';
import 'package:fox/modules/checkout/widget/checkout_basic_info.dart';
import 'package:fox/modules/profile/address/widget/address_item.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/custom_input_item.dart';

class CheckoutPayment extends StatelessWidget {
  CheckoutPayment({Key? key}) : super(key: key);

  final CheckoutPageController controller = Get.find<CheckoutPageController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: CheckoutBasicInfo(),
          ),
          SizedBox(
            key: controller.errorMessageGlobalKey,
            width: 1,
            height: 1,
          ),
          if (controller.creditCardError &&
              (double.parse(controller.checkout?.totalPriceV2?.amount ?? '')) !=
                  0)
            buildCreditErrorView(),
          if ((double.parse(controller.checkout?.totalPriceV2?.amount ?? '')) !=
              0)
            buildCreditView('worldpay'),
          if ((double.parse(controller.checkout?.totalPriceV2?.amount ?? '')) ==
              0)
            buildFreeView(),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
            child:
                const Text('Billing Address', style: AppTextStyle.BlackBold12),
          ),
          buildBillingAddressView(controller.selectBillingAddress),
          const SizedBox(height: 42 + 3),
          buildGiftCardOrDiscoUntView(),
          if (controller.discountCode.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 3,
                alignment: WrapAlignment.start,
                children: [buildGiftItem(controller.discountCode)],
              ),
            ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  buildCreditErrorView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: AppColors.RED_FF5B5B,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 11),
            width: 22,
            height: 22,
            child: Image.asset(
              LocalImages.asset('warning_red'),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.creditCardErrorMessage,
                style: AppTextStyle.Red14_CB0000,
              ),
            ),
          )
        ],
      ),
    );
  }

  buildCreditView(String paymentName) {
    Key? key = controller.worldPayFormKey;
    return Container(
      width: Get.width - 32,
      height: 316,
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: AppColors.GREY_9E9E9E,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 17, 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            const EdgeInsets.only(left: 0, right: 0, bottom: 3),
                        child: const Text(
                          'Credit or Debit Card',
                          style: AppTextStyle.Black16,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Container(
                      width: 122,
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        LocalImages.asset('pay_type'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              ...controller.worldpayInputList
                  .map((e) => CustomInputItem(
                        inputItems: e,
                      ))
                  .toList(),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 12,
                  top: 12,
                  bottom: 16,
                ),
                child: const Text(
                  'The security number is the three digits on the back of the card in the signature box.',
                  style: AppTextStyle.Black12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFreeView() {
    return Container(
      width: Get.width - 32,
      height: 100,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: AppColors.GREY_E0E0E0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            LocalImages.asset('payment_free'),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'The order is covered by your gift card',
            style: AppTextStyle.Black14,
          ),
        ],
      ),
    );
  }

  buildBillingAddressView(AddressModel address) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.sameAsShippingAddress)
            Container(
              height: 22,
              alignment: Alignment.centerLeft,
              child: const Text(
                'Same as shipping address',
                style: AppTextStyle.Grey14_9E9E9E,
              ),
            ),
          if (controller.sameAsShippingAddress)
            const SizedBox(
              height: 5,
            ),
          Container(
            alignment: Alignment.centerLeft,
            child: AddressItem(address, showPhone: false),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
              height: 1.0,
              decoration: const BoxDecoration(
                color: AppColors.GREY_E0E0E0,
              )),
          const SizedBox(
            height: 11,
          ),
          GestureDetector(
            onTap: () {
              controller.editBillingAddress();
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  LocalImages.asset('pen'),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Edit',
                      style: AppTextStyle.Black14,
                    ),
                  ),
                ),
                Image.asset(
                  LocalImages.asset('arrow'),
                ),
              ],
            ),
          ),
        ],
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
