import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/checkout/checkout_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';

class CheckoutBasicInfo extends StatelessWidget {
  CheckoutBasicInfo({Key? key}) : super(key: key);
  final CheckoutPageController controller = Get.find<CheckoutPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Contact',
                style: AppTextStyle.BlackBold12,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, bottom: 9, right: 0),
                child: Text(
                  controller.emailInputList[0][0].controller?.text ?? '',
                  style: AppTextStyle.Black12,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Address',
                style: AppTextStyle.BlackBold12,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 0),
                  child: Text(
                    '${controller.selectShippingAddress?.address1 ?? ''}, ${controller.selectShippingAddress?.address2 ?? ''}${(controller.selectShippingAddress?.address2 ?? '').isNotEmpty ? ', ' : ''}${controller.selectShippingAddress?.city ?? ''}, ${controller.selectShippingAddress?.country ?? ''}${(controller.selectShippingAddress?.country ?? '').isNotEmpty ? ', ' : ''}${controller.selectShippingAddress?.zip ?? ''}, ${controller.selectShippingAddress?.country ?? ''}',
                    style: AppTextStyle.Black12,
                  ),
                ),
              ),
            ],
          ),
          if (controller.tabController.index == 2)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Delivery',
                    style: AppTextStyle.BlackBold12,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Text(
                        controller.checkout?.shippingLine?.title ?? '',
                        style: AppTextStyle.Black12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (controller.tabController.index == 2)
            Container(
                height: 1.0,
                decoration: const BoxDecoration(
                  color: AppColors.GREY_E0E0E0,
                )),
          if (controller.tabController.index == 2)
            Container(
              height: 18,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 15),
              child: const Text(
                'Payment',
                style: AppTextStyle.BlackBold12,
              ),
            ),
          if (controller.tabController.index == 2)
            Container(
              height: 18,
              alignment: Alignment.centerLeft,
              child: const Text(
                'All transactions are secure and encrypted.',
                style: AppTextStyle.Black12,
              ),
            ),
        ],
      ),
    );
  }
}
