import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';
import 'package:fox/data/model/search/model/search_model.dart';
import 'package:fox/modules/search/searching_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/list_item.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class Searching extends StatelessWidget {
  Searching({Key? key}) : super(key: key);

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
            if (controller.historyList.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Search History',
                  style: AppTextStyle.Black12,
                ),
              ),
            if (controller.historyList.isNotEmpty)
              ..._buildHistoryItemList(controller.historyList),
            if (controller.historyList.isEmpty)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Suggested',
                  style: AppTextStyle.Black12,
                ),
              ),
            if (controller.historyList.isEmpty)
              ..._buildSuggestedItemList(controller.suggestedList),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHistoryItemList(List<SearchHistoryModel> list) {
    return list
        .map((history) => ListItem(
              text: history.name ?? "",
              hideArrow: true,
              onTap: () {
                controller.update();

                Get.toNamed(AppRouters.productList,
                    arguments: {'query': history.name});
              },
            ))
        .toList();
  }

  List<Widget> _buildSuggestedItemList(List<DesignerModel> list) {
    return list
        .map((designer) => ListItem(
              text: designer.name ?? "",
              hideArrow: true,
              onTap: () {
                // controller.showNav = true;
                controller.update();
                Get.toNamed(AppRouters.productList,
                    arguments: {'query': designer.name});
              },
            ))
        .toList();
  }
}
