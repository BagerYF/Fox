import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/order/order_model.dart';
import 'package:fox/modules/profile/address/widget/address_item.dart';
import 'package:fox/modules/profile/order/order_detail_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/network_image.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class OrderDetailPage extends GetView<OrderDetailPageController> {
  final OrderDetailPageController _controller =
      Get.put(OrderDetailPageController());

  OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(
        title: _controller.appbarTitle,
        elevation: 1,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 17,
            ),
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    rowItem(
                      'Subtotal',
                      Text(
                        '${_controller.model?.subtotalPriceV2?.currencyCode} ${_controller.model?.subtotalPriceV2?.amount}',
                        style: AppTextStyle.Black14,
                      ),
                    ),
                    rowItem(
                      'Shipping',
                      Text(
                        double.parse(_controller.model?.totalTaxV2?.amount ??
                                    '') ==
                                0
                            ? 'Free'
                            : '${_controller.model?.totalTaxV2?.currencyCode} ${_controller.model?.totalTaxV2?.amount}',
                        style: AppTextStyle.Black14,
                      ),
                    ),
                    rowItem(
                      'Taxes',
                      Text(
                        '${_controller.model?.totalTaxV2?.currencyCode} ${_controller.model?.totalTaxV2?.amount}',
                        style: AppTextStyle.Black14,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: totalItem(),
                ),
              ],
            ),
            divider(),
            rowItem(
              'Order Number',
              Text(
                '${_controller.model?.orderNumber}',
                style: AppTextStyle.Black14,
              ),
            ),
            rowItem(
              'Order Date',
              Text(
                '${_controller.model?.processedAt?.substring(0, 10)}',
                style: AppTextStyle.Black14,
              ),
            ),
            divider(),
            rowItem(
              'Shipping',
              const Text(
                'International Priority Express Shipping',
                style: AppTextStyle.Black14,
              ),
            ),
            divider(),
            rowItem(
              'Contact',
              Text(
                _controller.model?.email ?? '',
                style: AppTextStyle.Black14,
              ),
            ),
            rowItem(
              'Address',
              AddressItem(
                _controller.shippingAddress!,
                textStyle: AppTextStyle.Black14,
                showPhone: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            divider(),
            ScrollConfiguration(
              behavior: NoScrollBehavior(),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return listItem(_controller.items[index],
                        index != _controller.items.length - 1);
                  }),
            ),
            bottomContent(),
            returnItemsInfo()
          ],
        ),
      ),
    );
  }

  Widget rowItem(String title, Widget value) {
    var top = 0.0;
    if (title == 'Contact') {
      top = 0;
    } else if (title == 'Address') {
      top = 8;
    }
    return Container(
      // height: 22,
      constraints: const BoxConstraints(minHeight: 22),
      padding: EdgeInsets.only(top: top),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: title == 'Address'
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            width: 118,
            padding: EdgeInsets.only(
              top: title == 'Address' ? 2 : 0,
            ),
            child: Text(
              title,
              style: AppTextStyle.Grey14_9E9E9E,
            ),
          ),
          Expanded(child: value),
        ],
      ),
    );
  }

  Widget totalItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 22),
          alignment: Alignment.centerLeft,
          child: Text(
            'Total ${_controller.model?.totalPriceV2?.currencyCode} ${_controller.model?.totalPriceV2?.amount}',
            style: AppTextStyle.BlackBold14,
          ),
        ),
      ],
    );
  }

  Widget divider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColors.GREY_EEEEEE,
      margin: const EdgeInsets.only(top: 16, bottom: 8),
    );
  }

  Widget bottomContent() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouters.profileHelpAndContacts);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 25,
          ),
          Image.asset(LocalImages.asset('icon_order_problem')),
          const SizedBox(
            height: 7,
          ),
          const Text(
            'Help and Contact',
            style: AppTextStyle.BlackBold14,
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            width: 147,
            height: 36,
            child: Text(
              'Questions about your order? Don\'t hesitate to ask',
              style: TextStyle(
                  color: AppColors.GREY_616161,
                  fontSize: 12.0,
                  height: 18 / 12),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text('Contact Shopify',
              style: TextStyle(
                  color: AppColors.GREY_9E9E9E,
                  fontSize: 12.0,
                  decoration: TextDecoration.underline)),
        ],
      ),
    );
  }

  Widget returnItemsInfo() {
    if (_controller.canReturn) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.toNamed(AppRouters.profileReturnAndRefunds);
        },
        child: Container(
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 48, bottom: 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: AppColors.GREY_9E9E9E, width: 1)),
          child: const Text(
            'Return item(s)',
            style: AppTextStyle.Black16,
          ),
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          divider(),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'Return Information',
            style: TextStyle(
              fontFamily: AppTextStyle.BASEL_GROTESK_MEDIUM,
              fontSize: 14,
              height: 19.6 / 14,
              color: AppColors.BLACK,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'The eligible return period for this item(s) has expired. For more information, see our Return Policy.',
            style: TextStyle(
              fontFamily: AppTextStyle.BASEL_GROTESK,
              fontSize: 14,
              height: 22.4 / 14,
              color: AppColors.GREY_616161,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouters.profileReturnAndRefunds);
            },
            child: const Text('Return Policy',
                style: TextStyle(
                    fontFamily: AppTextStyle.BASEL_GROTESK,
                    fontSize: 12,
                    height: 16.8 / 12,
                    color: AppColors.GREY_9E9E9E,
                    decoration: TextDecoration.underline)),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
    }
  }

  Widget listItem(LineItemsModel cartItem, bool showLine) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 16),
        decoration: showLine
            ? const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.GREY_EEEEEE)),
              )
            : const BoxDecoration(),
        child: Row(
          children: [
            Container(
              width: 118,
              padding: const EdgeInsets.only(right: 16),
              alignment: Alignment.topCenter,
              child: AppCacheNetworkImage(
                type: CacheImageType.logo,
                imageUrl: cartItem.variant?.image,
                boxFit: BoxFit.contain,
                width: 104,
                height: 140,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.variant?.product?.productType ?? '',
                              style: AppTextStyle.BlackBold14,
                            ),
                            Text(
                              cartItem.title ?? '',
                              style: AppTextStyle.Black14,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                        child: Text(
                          'Size',
                          style: AppTextStyle.Black14,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cartItem.variant?.size ?? '',
                        style: AppTextStyle.Black14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                        child: Text(
                          'Color',
                          style: AppTextStyle.Black14,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cartItem.variant?.color ?? '',
                        style: AppTextStyle.Black14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                        child: Text(
                          'Qty',
                          style: AppTextStyle.Black14,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${cartItem.quantity ?? 1}',
                        style: AppTextStyle.Black14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 50,
                        child: Text(
                          'Price',
                          style: AppTextStyle.Black14,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${cartItem.originalTotalPrice?.currencyCode} ${cartItem.originalTotalPrice?.amount}',
                        style: AppTextStyle.BlackBold14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
