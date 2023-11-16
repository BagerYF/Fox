import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/order/order_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/profile/order/order_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:fox/utils/widget/network_image.dart';

class OrderPage extends StatelessWidget {
  final MyOrderPageController _controller = Get.put(MyOrderPageController());

  OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Orders',
        elevation: 1,
        actions: [
          CartPageController.to.cartView,
        ],
      ),
      body: GetBuilder<MyOrderPageController>(
        init: MyOrderPageController(),
        initState: (_) {},
        builder: (_) {
          return buildBody();
        },
      ),
    );
  }

  Widget buildBody() {
    Widget widget;
    switch (_controller.pageStatus) {
      case PageStatus.init:
        widget = const Loading();
        break;
      case PageStatus.normal:
        widget = SmartRefresher(
          controller: _controller.refreshController,
          enablePullDown: false,
          enablePullUp: false,
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 32),
              itemCount: _controller.orderList.length,
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return listItem(_controller.orderList[index]);
              }),
        );
        break;
      default:
        widget = const SizedBox();
    }
    return widget;
  }

  Widget listItem(OrderModel myOrderModel) {
    List<LineItemsModel> items = myOrderModel.lineItems ?? [];
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouters.orderDetailPage, arguments: myOrderModel);
      },
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: AppColors.GREY_E0E0E0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Order#  ',
                  style: AppTextStyle.Grey14_9E9E9E,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Text(
                  '${myOrderModel.orderNumber}',
                  style: AppTextStyle.Black14,
                )),
                Text(
                  myOrderModel.processedAt!.substring(0, 10),
                  style: AppTextStyle.Black14,
                ),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  height: 18,
                  child: Image.asset(
                    LocalImages.asset('arrow'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 84,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AppCacheNetworkImage(
                        type: CacheImageType.logo,
                        imageUrl: e.variant?.image,
                        boxFit: BoxFit.contain,
                        width: 59,
                        height: 84,
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
