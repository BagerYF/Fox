import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/product/product_list_page_controller.dart';
import 'package:fox/modules/product/widget/product_filter_bar.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/app_text_style.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/refresh_loading_widget.dart';

// ignore: must_be_immutable
class ProductListPage extends StatelessWidget {
  late ProductListPageController controller;

  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tag = DateTime.now().millisecondsSinceEpoch.toString();

    controller = Get.put(ProductListPageController(), tag: tag);

    return GetBuilder<ProductListPageController>(
      tag: tag,
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Product',
            elevation: 1,
            actions: [CartPageController.to.cartView],
          ),
          body: Column(
            children: [
              ProductFilterBar(controller, tag),
              Expanded(child: buildRefresh()),
            ],
          ),
        );
      },
    );
  }

  Widget buildRefresh() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const ClassicHeader(
        completeIcon: SizedBox(),
        completeDuration: Duration(milliseconds: 50),
        completeText: '',
        idleIcon: Icon(
          Icons.arrow_downward_rounded,
          color: Colors.grey,
        ),
        idleText: 'Pull down to refresh',
        refreshingIcon: RefreshLoading(),
      ),
      footer: const ClassicFooter(
        loadingIcon: RefreshLoading(),
      ),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: buildGridView(),
    );
  }

  buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 0.52,
      ),
      itemCount: controller.productList.length,
      itemBuilder: (context, index) {
        Product product = controller.productList[index];
        return buildItem(product);
      },
    );
  }

  buildItem(Product product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouters.productDetail,
            arguments: {'id': product.id}, preventDuplicates: false);
      },
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: 150,
            height: 210,
            child: CachedNetworkImage(
                imageUrl: product.images!.isNotEmpty
                    ? product.images?.first ??
                        'https://img2.baidu.com/it/u=1585458193,188380332&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500'
                    : 'https://img2.baidu.com/it/u=1585458193,188380332&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            alignment: Alignment.center,
            child: Text(
              product.title ?? '',
              textAlign: TextAlign.center,
              style: AppTextStyle.Black14,
              maxLines: 1,
            ),
          ),
          if (product.productType != null && product.productType!.isNotEmpty)
            Container(
              alignment: Alignment.center,
              child: Text(
                product.productType ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle.Grey12_9E9E9E,
                maxLines: 1,
              ),
            ),
          Container(
            alignment: Alignment.center,
            child: Text(
              product.vendor ?? '',
              textAlign: TextAlign.center,
              style: AppTextStyle.Grey12_757575,
              maxLines: 1,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            alignment: Alignment.center,
            // color: Colors.green,
            child: Text(
              '${product.variants?[0].price?.currencyCode ?? ''}  ${product.variants?[0].price?.amount ?? ''}',
              textAlign: TextAlign.center,
              style: AppTextStyle.Black14,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
