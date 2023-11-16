import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/profile/address/saved_address_detail_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/custom_input_item.dart';

class SavedAddressDetailPage extends GetView<SavedAddressDetailPageController> {
  @override
  final SavedAddressDetailPageController controller =
      Get.put(SavedAddressDetailPageController());
  final bottomSafe = Get.context!.mediaQueryPadding.bottom;

  SavedAddressDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedAddressDetailPageController>(
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: controller.tempAddress == null
                ? controller.billingAddress
                    ? 'Add Billing Address'
                    : 'Add Address'
                : controller.billingAddress
                    ? 'Update Billing Address'
                    : 'Update Address',
            elevation: 1,
          ),
          body: Form(
            key: controller.addressFormKey,
            onChanged: () {
              controller.update();
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: const Text(
                          '*Required Fields',
                          style: AppTextStyle.Black12,
                        ),
                      ),
                      ...controller.addressInputList
                          .map((e) => CustomInputItem(
                                inputItems: e,
                              ))
                          .toList(),
                      if (!controller.billingAddress && controller.showDefault)
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 40,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (!controller.showKeyboard)
                  BottomAnimationButton(
                    controller: controller.btnController,
                    text: controller.tempAddress == null
                        ? controller.billingAddress
                            ? 'Save Billing Address'
                            : 'Add Address'
                        : controller.billingAddress
                            ? 'Update Billing Address'
                            : 'Update Address',
                    margin: const EdgeInsets.only(bottom: 0),
                    onTap: () {
                      controller.updateAddressClick();
                    },
                  ),
                SizedBox(
                  height: bottomSafe == 0 ? 24 : bottomSafe + 12,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
