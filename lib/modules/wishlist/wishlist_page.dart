import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/wishlist/wishlist_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({Key? key}) : super(key: key);
  final WishlistController controller = WishlistController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Wishlist',
            elevation: 1,
            actions: [CartPageController.to.cartView],
          ),
          body: controller.productList.isEmpty ? emptyView() : buildGridView(),
        );
      },
    );
  }

  Widget emptyView() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 249),
      child: const Text(
        "Your Wishlist is currently empty",
        style: AppTextStyle.Black16,
      ),
    );
  }

  buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2, //每行三列
        childAspectRatio: 0.52, //显示区域宽高相等
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
        Get.toNamed(AppRouters.productDetail, arguments: {'id': product.id});
      },
      child: Stack(
        children: [
          Column(
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
              if (product.productType != null &&
                  product.productType!.isNotEmpty)
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
                child: Text(
                  '\$  ${product.variants?[0].price ?? ''}',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.Black14,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                controller.removeProductFromWishlist(product);
              },
              child: Stack(
                children: [
                  const SizedBox(
                    width: 28,
                    height: 28,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 2),
                    child: Image.asset(
                      LocalImages.asset('wishlist_colse'),
                      width: 18,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
