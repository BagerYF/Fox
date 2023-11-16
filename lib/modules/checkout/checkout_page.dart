import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/modules/checkout/checkout_page_controller.dart';
import 'package:fox/modules/checkout/widget/checkout_address.dart';
import 'package:fox/modules/checkout/widget/checkout_delivery.dart';
import 'package:fox/modules/checkout/widget/checkout_payment.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class CheckoutPage extends StatelessWidget {
  CheckoutPage({Key? key}) : super(key: key);
  final CheckoutPageController controller = Get.put(CheckoutPageController());
  var bottomSafe = Get.context!.mediaQueryPadding.bottom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutPageController>(
      init: controller,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.pageStatus == PageStatus.processing) {
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            appBar: navView(),
            body: bodyView(),
          ),
        );
      },
    );
  }

  navView() {
    CustomAppBar tempWidget;
    switch (controller.pageStatus) {
      case PageStatus.normal:
        tempWidget = CustomAppBar(
          titleWidget: SizedBox(
            width: 62 * 3 + 32,
            child: TabBar(
              onTap: (int index) {
                controller.tabController.index = index;
                controller.update();
                if (index > controller.tabController.previousIndex) {
                  controller.tabController.index =
                      controller.tabController.previousIndex;
                } else {
                  controller.update();
                }
              },
              isScrollable: false,
              labelPadding: const EdgeInsets.only(left: 0, right: 0, top: 5),
              controller: controller.tabController,
              labelColor: Colors.black,
              unselectedLabelColor: AppColors.GREY_B3B3B3,
              labelStyle: AppTextStyle.BlackBold16,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: controller.typeList.map((type) {
                var index = controller.typeList.indexOf(type);
                if (controller.tabController.index >= index) {
                  return Text(
                    type,
                    style: AppTextStyle.BlackBold16,
                  );
                } else {
                  return Text(
                    type,
                    style: AppTextStyle.Grey16_9E9E9E,
                  );
                }
              }).toList(),
            ),
          ),
        );
        break;
      case PageStatus.processing:
        tempWidget = const CustomAppBar(
          title: 'Processing',
          back: false,
        );
        break;
      case PageStatus.success:
        tempWidget = const CustomAppBar(
          title: 'Order Complete',
          back: false,
        );
        break;
      case PageStatus.fail:
        tempWidget = const CustomAppBar(
          title: 'Payment failed',
          back: false,
        );
        break;
      default:
        tempWidget = const CustomAppBar(
          title: 'Checkout',
        );
    }
    return tempWidget;
  }

  bodyView() {
    Widget tempWidget;
    switch (controller.pageStatus) {
      case PageStatus.init:
        tempWidget = const Loading();
        break;
      case PageStatus.webview:
        tempWidget = WebViewWidget(controller: controller.webViewController);
        break;
      case PageStatus.normal:
        tempWidget = ScrollConfiguration(
          behavior: NoScrollBehavior(),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: [
                      CheckoutAddress(),
                      CheckoutDelivery(),
                      CheckoutPayment(),
                    ]),
              ),
              const Divider(
                height: 1,
                color: AppColors.GREY_EEEEEE,
              ),
              if (!controller.showKeyboard) bottomView(),
              if (!controller.showKeyboard)
                BottomAnimationButton(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  controller: controller.btnController,
                  text: (controller.tabController.index == 0 ||
                          controller.tabController.index == 1)
                      ? 'Next'
                      : 'Place Order',
                  onTap: () {
                    controller.next();
                  },
                ),
              SizedBox(
                height: bottomSafe == 0 ? 24 : bottomSafe + 12,
              )
            ],
          ),
          // ),
        );
        break;
      case PageStatus.processing:
        tempWidget = const SizedBox();
        break;
      case PageStatus.error:
        tempWidget = Container(
          alignment: Alignment.topCenter,
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Text(
                controller.errorMsg,
                textAlign: TextAlign.center,
                style: AppTextStyle.Black16,
              )),
        );
        break;
      case PageStatus.success:
        tempWidget = Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          LocalImages.asset('success'),
                        ),
                      ),
                      Container(
                        width: 288,
                        margin: const EdgeInsets.only(top: 24),
                        child: const Text(
                          'Your order is complete ',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.BlackBold16,
                        ),
                      ),
                      Container(
                        width: 288,
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text(
                          'A confirmation email will be sent to your email box',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.Black16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomButton(
              margin: EdgeInsets.fromLTRB(
                  16, 16, 16, bottomSafe == 0 ? 24 : bottomSafe + 12),
              text: 'Continue Shopping',
              onTap: () {
                Get.until((route) => Get.currentRoute == AppRouters.main);
              },
            ),
          ],
        );
        break;
      case PageStatus.fail:
        tempWidget = Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          LocalImages.asset('fail'),
                        ),
                      ),
                      Container(
                        width: 288,
                        margin: const EdgeInsets.only(top: 24),
                        child: const Text(
                          'We could not process your order',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.BlackBold16,
                        ),
                      ),
                      Container(
                        width: 288,
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          controller.getErrorMessage(),
                          textAlign: TextAlign.center,
                          style: AppTextStyle.BlackBold16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        width: 170,
                        height: 40,
                        child: BottomButton(
                          text: 'Try again',
                          onTap: () {
                            controller.pageStatus = PageStatus.normal;
                            controller.update();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: const Text(
                            'Back to Shopping Bag',
                            style: AppTextStyle.Black12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      default:
        tempWidget = const SizedBox();
    }
    return tempWidget;
  }

  bottomView() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 70,
                          child: Text(
                            'Subtotal',
                            style: AppTextStyle.Black14,
                          )),
                      Expanded(
                        child: Text(
                          '${controller.checkout?.lineItemsSubtotalPrice?.currencyCode} ${controller.checkout?.lineItemsSubtotalPrice?.amount}',
                          textAlign: TextAlign.left,
                          style: AppTextStyle.Black14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Total ${controller.checkout?.totalPriceV2?.currencyCode} ${controller.checkout?.totalPriceV2?.amount}',
                style: AppTextStyle.BlackBold16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.checkout?.shippingLine == null
                  ? controller.discountCode.isNotEmpty
                      ? bottomDiscountView()
                      : const SizedBox()
                  : Expanded(
                      child: SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 70,
                              child: Text(
                                'Shipping',
                                style: AppTextStyle.Black14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (controller.checkout?.shippingLine?.priceV2
                                                ?.amount ??
                                            0) ==
                                        0
                                    ? 'Free'
                                    : '${controller.checkout?.shippingLine?.priceV2?.currencyCode} ${controller.checkout?.shippingLine?.priceV2?.amount}',
                                textAlign: TextAlign.left,
                                style: AppTextStyle.Black14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          if (controller.discountCode.isNotEmpty &&
              controller.checkout?.shippingLine != null)
            Row(
              children: [
                bottomDiscountView(),
              ],
            ),
          if (double.parse(controller.checkout?.totalTaxV2?.amount ?? '') > 0)
            Row(
              children: [
                bottomTaxView(),
              ],
            ),
        ],
      ),
    );
  }

  bottomDiscountView() {
    return Expanded(
      child: SizedBox(
        height: 20,
        child: Row(
          children: [
            const SizedBox(
                width: 70,
                child: Text(
                  'Discount',
                  style: AppTextStyle.Black14,
                )),
            Expanded(
              child: Text(
                '${controller.checkout?.currencyCode} -${controller.discountValue}',
                textAlign: TextAlign.left,
                style: AppTextStyle.Black14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomTaxView() {
    return Expanded(
      child: SizedBox(
        height: 20,
        child: Row(
          children: [
            const SizedBox(
                width: 70,
                child: Text(
                  'Tax',
                  style: AppTextStyle.Black14,
                )),
            Expanded(
              child: Text(
                '${controller.checkout?.totalTaxV2?.currencyCode} ${controller.checkout?.totalTaxV2?.amount}',
                textAlign: TextAlign.left,
                style: AppTextStyle.Black14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
