import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/product/product_detail_page_controller.dart';
import 'package:fox/modules/product/widget/product_detail_pageview.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:fox/utils/widget/network_image.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatelessWidget {
  late ProductDetailPageController controller;

  ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tag = Get.arguments['id'].toString();
    controller = Get.put(ProductDetailPageController(), tag: tag);
    return GetBuilder<ProductDetailPageController>(
      tag: tag,
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: '',
            elevation: 1,
            actions: [CartPageController.to.cartView],
          ),
          body: buildBody(),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  buildBody() {
    Widget body = const SizedBox();
    switch (controller.pageStatus) {
      case PageStatus.loading:
        body = const Loading(
          hasBar: false,
        );
        break;
      case PageStatus.success:
        body = Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          var image = controller.productDetail.images?[index];
                          return CachedNetworkImage(
                              imageUrl: image ??
                                  'https://img2.baidu.com/it/u=1585458193,188380332&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500');
                        },
                        itemCount:
                            (controller.productDetail.images ?? []).length,
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.black,
                            size: 8,
                            activeSize: 8,
                          ),
                        ),
                      ),
                    ),
                    ...buildTitle(),
                    ...buildSize(),
                    buildDescription(),
                    buildReturns(),
                    buildRecommentds(),
                  ],
                ),
              ),
            ),
            BottomButton(
              text: 'Add to bag',
              onTap: () {
                controller.addToBag();
              },
            ),
          ],
        );
        break;
      default:
    }
    return body;
  }

  buildTitle() {
    return [
      const SizedBox(
        height: 18,
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left: 16),
        child: Text(
          controller.productDetail.vendor ?? "",
          style: AppTextStyle.Black24,
        ),
      ),
      const SizedBox(height: 4),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left: 16),
        child: Text(
          controller.productDetail.title ?? "",
          style: AppTextStyle.Black16,
        ),
      ),
      const SizedBox(
        height: 18,
      ),
      Container(
        margin: const EdgeInsets.only(left: 16),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (controller.variant?.compareAtPrice != null)
                      Text(
                        '${controller.variant?.compareAtPrice?.currencyCode ?? ''} ${controller.variant?.compareAtPrice?.amount ?? ''}',
                        style: AppTextStyle.Grey14_757575_LineThrough,
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(
                      width: controller.variant?.compareAtPrice == null ? 0 : 6,
                    ),
                    Text(
                      '${controller.variant?.price?.currencyCode ?? ''} ${controller.variant?.price?.amount ?? ''}',
                      style: TextStyle(
                        color: controller.variant?.compareAtPrice != null
                            ? AppColors.RED_CB0000
                            : AppColors.GREY_212121,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    controller.addWishlist();
                  },
                  child: Row(
                    children: [
                      Text(
                        controller.isAddedWishlist
                            ? "Added to Wishlist"
                            : "Add to Wishlist",
                        style: AppTextStyle.Black14,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 16, 0),
                        child: Image.asset(
                          LocalImages.asset(controller.isAddedWishlist
                              ? 'porduct_detail_star_select'
                              : 'porduct_detail_star'),
                          width: 18,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ];
  }

  buildSize() {
    return [
      if (controller.hasMultiSize)
        Container(
          margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  LocalImages.asset('porduct_detail_size'),
                  fit: BoxFit.cover,
                  width: 16,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  "Size Guide",
                  style: TextStyle(
                    color: AppColors.BLACK,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      if (controller.hasMultiSize)
        GestureDetector(
          onTap: () {
            controller.showModalBottomSheetPick();
          },
          child: Container(
            height: 48,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              border: Border.all(
                width: 1,
                color: AppColors.GREY_616161,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Offstage(
                        offstage: false,
                        child: RichText(
                          text: TextSpan(
                            text: 'Size ',
                            style: AppTextStyle.Black16,
                            children: <TextSpan>[
                              TextSpan(
                                text: controller.variant?.title,
                                style: AppTextStyle.Grey16_757575,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        LocalImages.asset('porduct_detail_arrow'),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    ];
  }

  buildDescription() {
    // ignore: unnecessary_null_comparison
    return controller.productDetail != null
        ? Container(
            margin: const EdgeInsets.fromLTRB(16, 20, 0, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description",
                  style: AppTextStyle.Black16,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(_removeTag(controller.productDetail.description),
                    style: AppTextStyle.Black16),
              ],
            ),
          )
        : const SizedBox();
  }

  buildReturns() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1.0,
            indent: 0.0,
            color: AppColors.GREY_E0E0E0,
          ),
          SizedBox(
            height: 48,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Text(
                      "Shipping and Returns",
                      style: AppTextStyle.Black16,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Delivery Destinations",
                style: AppTextStyle.Black16,
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 78,
                child: Text(
                  "Shopify ships globally to a large number of countries. For more information on delivery, visit our orders & shipping page.",
                  style: TextStyle(
                      fontSize: 16, color: AppColors.BLACK, height: 25.6 / 16),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 2,
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 22,
                child: Text(
                  "Returns",
                  style: AppTextStyle.Black16,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "You can purchase in confidence and send the items back to us if they are not right for you. If you would like to initiate a return, please go to your account at the top right corner where it says your name. Click \"Create Return\" next to the order your would like to return and follow the prompts.",
                style: TextStyle(
                    fontSize: 16, color: AppColors.BLACK, height: 25.6 / 16),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 2,
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: AppColors.GREY_E0E0E0,
          ),
        ],
      ),
    );
  }

  String _removeTag(String? htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText?.replaceAll(exp, '\n') ?? '';
  }

  buildRecommentds() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 16,
        ),
        RichText(
          text: const TextSpan(
            text: 'Recommended ',
            style: AppTextStyle.Black16,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            ProductDetailPageView(
              widgetList: _getWidgetList(),
              pageContent: PageContentType.BottomPage,
            ),
          ],
        ),
        const SizedBox(
          height: 27,
        ),
      ]),
    );
  }

  List<Widget> _getWidgetList() {
    List<Widget> widgetList = [];

    for (var element in controller.recommendList) {
      widgetList.add(_buildRecommendItem(product: element));
    }
    return widgetList;
  }

  _buildRecommendItem({@required Product? product}) {
    return SizedBox(
      width: Get.width / 2 - 16 - 8.5,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRouters.productDetail,
              arguments: {'id': product!.id}, preventDuplicates: false);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCacheNetworkImage(
                type: CacheImageType.logo,
                imageUrl: product!.images!.isNotEmpty
                    ? product.images?.first ??
                        'https://img2.baidu.com/it/u=1585458193,188380332&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500'
                    : 'https://img2.baidu.com/it/u=1585458193,188380332&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500',
                width: 163,
                height: 210,
                boxFit: BoxFit.contain),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 20,
              child: Text(
                product.vendor ?? "",
                style: AppTextStyle.BlackBold14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    '${product.variants?[0].priceV2?.currencyCode ?? ''} ${product.variants?[0].priceV2?.amount ?? ''}',
                    style: AppTextStyle.Grey16_616161,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
