import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/checkout/address/checkout_select_address_page_controller.dart';
import 'package:fox/modules/profile/address/widget/address_item.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';

class CheckoutSelectAddressPage extends StatelessWidget {
  CheckoutSelectAddressPage({Key? key}) : super(key: key);
  final CheckoutSelectAddressPageController controller =
      Get.put(CheckoutSelectAddressPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutSelectAddressPageController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Billing Address',
            elevation: 1,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: addressListView(),
              ),
              BottomButton(
                text: 'Save and Continue',
                onTap: () {
                  Get.back(
                    result: controller.selectBillingAddress,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  addressListView() {
    return ListView.builder(
      itemCount: controller.addressList.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: const Text(
              'Select an address',
              style: AppTextStyle.BlackBold12,
            ),
          );
        } else if (index == controller.addressList.length + 1) {
          return GestureDetector(
            onTap: () {
              controller.addAddress();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 16, left: 16, bottom: 50),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.BLACK,
                  ),
                  Text(
                    'Add address',
                    style: AppTextStyle.Black14,
                  ),
                ],
              ),
            ),
          );
        } else {
          var address = controller.addressList[index - 1];
          var textStyle = address.billSelected
              ? AppTextStyle.Black14
              : AppTextStyle.Grey14_757575;
          return GestureDetector(
            onTap: () {
              controller.selectAddress(address);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    width: 1.0,
                    color: address.billSelected
                        ? AppColors.GREY_9E9E9E
                        : AppColors.GREY_E0E0E0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    margin: const EdgeInsets.only(right: 16),
                    child: address.billSelected == true
                        ? Image.asset(
                            LocalImages.asset('selected'),
                            width: 16,
                            height: 16,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            LocalImages.asset('unselected'),
                            width: 16,
                            height: 16,
                            fit: BoxFit.fill,
                          ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (address.selected)
                          Container(
                            height: 22,
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Same as shipping address',
                              style: AppTextStyle.Grey14_9E9E9E,
                            ),
                          ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: AddressItem(
                            address,
                            textStyle: textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
