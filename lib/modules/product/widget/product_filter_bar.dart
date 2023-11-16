import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/product/product_list_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/list_item.dart';
import 'package:fox/utils/widget/pick_one_view.dart';

// ignore: must_be_immutable
class ProductFilterBar extends StatelessWidget {
  ProductFilterBar(this.controller, this.tag, {Key? key}) : super(key: key);
  ProductListPageController controller;
  String tag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: Row(
              mainAxisAlignment: controller.allFilters.isNotEmpty
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (controller.allFilters.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      showFilterModalBottomSheetPick(controller);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Image.asset(
                            LocalImages.asset('product_refine'),
                            fit: BoxFit.fitWidth,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Filter',
                            style: AppTextStyle.Black14,
                          ),
                        ],
                      ),
                    ),
                  ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showSortModalBottomSheetPick(controller);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          '${controller.sort.name}',
                          style: AppTextStyle.Black14,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3 + 16),
                        child: Image.asset(
                          LocalImages.asset('product_down_arrow'),
                          fit: BoxFit.fitWidth,
                          width: 11,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  final String title = 'Sort by';

  showSortModalBottomSheetPick(
      ProductListPageController productListController) {
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 0),
                // color: AppColors.WHITE,
                child: PickOneView(
                  title: title,
                  scrollable: false,
                  selectIndex: productListController.sortIndex,
                  pickItems: productListController.sortTypeList,
                  callback: (index) {
                    productListController.sortProduct(index);
                  },
                ),
              ),
            ),
          );
        },
        context: Get.context!,
        barrierColor: Colors.black.withOpacity(0.4));
  }

  showFilterModalBottomSheetPick(
      ProductListPageController productListController) {
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (BuildContext context) {
          return GetBuilder<ProductListPageController>(
            tag: tag,
            builder: (_) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Column(
                      children: <Widget>[
                        titleView(),
                        filterListView(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        context: Get.context!,
        barrierColor: Colors.black.withOpacity(0.4));
  }

  Widget filterListView() {
    return Row(
      children: [
        Container(
          width: Get.width * 0.3,
          height: Get.height - 200,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.0, color: AppColors.GREY_EEEEEE),
            right: BorderSide(width: 1.0, color: AppColors.GREY_EEEEEE),
          )),
          child: ListView(
            children: <Widget>[
              ...controller.allFilters
                  .map(
                    (e) => ListItem(
                      padding: const EdgeInsets.only(left: 16, right: 0),
                      color: e.selected == true
                          ? AppColors.BLACK
                          : AppColors.GREY_9E9E9E,
                      text: e.label ?? '',
                      hideArrow: true,
                      onTap: () {
                        controller.selectFilter(e);
                      },
                    ),
                  )
                  .toList()
            ],
          ),
        ),
        Container(
          width: Get.width * 0.7,
          height: Get.height - 200,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.0, color: AppColors.GREY_EEEEEE),
          )),
          child: ListView(
            children: <Widget>[
              ...controller.subFilters
                  .map(
                    (e) => ListItemSelect(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      color: e.selected == true
                          ? AppColors.BLACK
                          : AppColors.GREY_9E9E9E,
                      text: e.label!.contains('Price')
                          ? '${e.label}'
                          : '${e.label} (${e.count})',
                      selected: e.selected,
                      onTap: () {
                        controller.selectSubFilter(e);
                      },
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ],
    );
  }

  Widget titleView() {
    return SizedBox(
      width: Get.width,
      height: 64,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Filter',
                  style: AppTextStyle.Black14,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clearFilter();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Clear',
                  style: AppTextStyle.Black14,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.clear,
                size: 16,
                color: AppColors.BLACK,
              ),
            )
          ]),
    );
  }
}
