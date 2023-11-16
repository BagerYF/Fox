import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/search/searching_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class SearchFail extends StatelessWidget {
  SearchFail({Key? key}) : super(key: key);

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
            if (controller.textEditingController.text.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sorry, there are no products related to “${controller.textEditingController.text}”',
                  style: AppTextStyle.Black16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
