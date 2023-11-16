import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/home/home_page_controller.dart';
import 'package:fox/modules/home/widget/home_sections.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomepageController controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(
        title: 'Shopify',
        actions: [CartPageController.to.cartView],
      ),
      body: GetBuilder<HomepageController>(
        assignId: true,
        builder: (logic) {
          return HomeSections(
            sortedSections: controller.sortedSections,
          );
        },
      ),
    );
  }
}
