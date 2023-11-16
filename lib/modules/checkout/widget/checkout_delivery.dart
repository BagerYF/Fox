import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/checkout/checkout_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/modules/checkout/checkout_page_controller.dart';
import 'package:fox/modules/checkout/widget/checkout_basic_info.dart';
import 'package:fox/theme/styles/styles.dart';

class CheckoutDelivery extends StatelessWidget {
  CheckoutDelivery({Key? key}) : super(key: key);

  final CheckoutPageController controller = Get.find<CheckoutPageController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.GREY_EEEEEE, width: 1))),
            child: CheckoutBasicInfo(),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: const Text(
              'Shipping Methods',
              style: AppTextStyle.BlackBold12,
            ),
          ),
          ...?controller.checkout?.availableShippingRates?.shippingRates
              ?.map((e) => buildShippingMethodItem(e))
              .toList(),
        ],
      ),
    );
  }

  buildShippingMethodItem(ShippingRates shippingRate) {
    return GestureDetector(
      onTap: () {
        if (shippingRate.handle == controller.checkout?.shippingLine?.handle) {
          return;
        }
        controller.checkoutShippingLineUpdate(
          shippingRate,
          loadingType: LoadingType.display,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: Get.width - 32,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: AppColors.GREY_9E9E9E),
            borderRadius: BorderRadius.circular(2.0)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 4),
                child: shippingRate.handle ==
                        controller.checkout?.shippingLine?.handle
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
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin:
                          const EdgeInsets.only(left: 16, bottom: 4, right: 14),
                      child: Text(
                        shippingRate.title ?? '',
                        style: AppTextStyle.Black16,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 16, right: 14),
                      child: Text(
                        (shippingRate.priceV2?.amount ?? 0) == 0
                            ? 'Free'
                            : '${shippingRate.priceV2?.currencyCode} ${shippingRate.priceV2?.amount}',
                        style: AppTextStyle.Black12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
