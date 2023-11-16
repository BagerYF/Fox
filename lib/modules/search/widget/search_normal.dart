import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/category/model/category_model.dart';
import 'package:fox/modules/search/search_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/list_item.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class SearchNormal extends StatelessWidget {
  SearchNormal({Key? key}) : super(key: key);

  final SearchPageController controller = Get.find<SearchPageController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              height: 17,
              margin: const EdgeInsets.only(
                left: 16,
                top: 8,
                bottom: 16,
              ),
              child: const Text(
                'Department',
                style: AppTextStyle.Black12,
              ),
            ),
            if (controller.firstLevelCategoryList.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 14),
                alignment: Alignment.centerLeft,
                child: TabBar(
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.only(left: 0, right: 5),
                  controller: controller.tabController,
                  indicatorColor: AppColors.WHITE,
                  indicatorWeight: 0.01,
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (index) {
                    for (var i = 0;
                        i < controller.firstLevelCategoryList.length;
                        i++) {
                      var item = controller.firstLevelCategoryList[i];
                      if (i == index) {
                        item.selected = true;
                      } else {
                        item.selected = false;
                      }
                    }
                    controller.update();
                  },
                  tabs: controller.firstLevelCategoryList.map((category) {
                    if (category.selected == true) {
                      return Container(
                        height: 32,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.BLACK, width: 1.0),
                            color: AppColors.BLACK,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Text(
                          category.name ?? '',
                          style: AppTextStyle.White16,
                        ),
                      );
                    } else {
                      return Container(
                        height: 32,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.WHITE_EEEEEE, width: 1.0),
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Text(
                          category.name ?? '',
                          style: AppTextStyle.Grey16_616161H,
                        ),
                      );
                    }
                  }).toList(),
                ),
              ),
            const SizedBox(height: 16),
            controller.firstLevelCategoryList.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: TabBarView(
                        controller: controller.tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: controller.firstLevelCategoryList
                            .map<Widget>((category) => _buildItemList(category))
                            .toList()),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(CategoryModel c) {
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: ListView(
        children: c.children!
            .map((category) => ListItem(
                text: category.name ?? '',
                color: category.name == 'Sale'
                    ? AppColors.RED_CB0000
                    : AppColors.BLACK,
                onTap: () {
                  Get.toNamed(AppRouters.searchCategoryPage,
                      arguments: {"department": c.name, "tags": category.name});
                }))
            .toList(),
      ),
    );
  }
}
