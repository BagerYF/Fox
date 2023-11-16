import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/modules/search/searching_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class SearchSuccess extends StatelessWidget {
  SearchSuccess({Key? key}) : super(key: key);

  final SearchingPageController controller =
      Get.find<SearchingPageController>();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            if (controller.designersList.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Designers',
                  style: AppTextStyle.Black12,
                ),
              ),
            ..._buildDesignerList(controller.designersList),
            if (controller.productsList.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Products',
                  style: AppTextStyle.Black12,
                ),
              ),
            ..._buildProductList(controller.productsList),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDesignerList(List<DesignerModel> list) {
    return list
        .map(
          (designer) => GestureDetector(
              onTap: () {
                Get.toNamed(AppRouters.productList,
                    arguments: {'query': designer.name});
              },
              child: Container(
                width: Get.width,
                height: 48,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.GREY_EEEEEE, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        designer.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.Black16,
                      ),
                    ),
                  ],
                ),
              )),
        )
        .toList();
  }

  List<Widget> _buildProductList(List<Product> list) {
    return list
        .map(
          (product) => GestureDetector(
              onTap: () {
                Get.toNamed(AppRouters.productDetail);
              },
              child: Container(
                width: Get.width,
                height: 48,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.GREY_EEEEEE, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        product.title ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.Black16,
                      ),
                    ),
                  ],
                ),
              )),
        )
        .toList();
  }
}
