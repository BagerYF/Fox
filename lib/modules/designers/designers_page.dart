import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/designers/designers_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/list_item.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class DesignersPage extends StatelessWidget {
  const DesignersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Designers',
          actions: [CartPageController.to.cartView],
        ),
        body: GetBuilder<DesignersPageController>(
          init: DesignersPageController(),
          builder: (controller) => ScrollConfiguration(
            behavior: NoScrollBehavior(),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 115),
              children: <Widget>[
                ListItem(
                    text: 'Designers A–Z',
                    onTap: () {
                      Get.toNamed(AppRouters.designersPageList);
                    }),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 24, bottom: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Feature Designers',
                    style: AppTextStyle.BlackBold14,
                  ),
                ),
                ...buildDesignerItemList(controller.designersList)
              ],
            ),
          ),
        ));
  }

  List<Widget> buildDesignerItemList(List<DesignerModel> designersList) {
    return designersList
        .map<Widget>((e) => ListItem(
            text: e.name ?? '',
            onTap: () {
              Get.toNamed(AppRouters.productList, arguments: {'query': e.name});
            }))
        .toList();
  }
}
