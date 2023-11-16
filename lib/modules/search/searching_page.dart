import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/search/searching_page_controller.dart';
import 'package:fox/modules/search/widget/search_normal.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';

class SearchingPage extends StatelessWidget {
  final SearchingPageController controller = Get.put(SearchingPageController());

  SearchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchingPageController>(
      builder: (_) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: buildSecondView(controller),
          ),
        );
      },
    );
  }

  buildFirstView(SearchingPageController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          title: 'Search',
          back: false,
          actions: [CartPageController.to.cartView],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.WHITE_EEEEEE, width: 0.0),
                          color: AppColors.WHITE_EEEEEE,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(LocalImages.asset('search')),
                            ),
                            const Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: -9),
                                border: InputBorder.none,
                                hintText: 'Search',
                                hintStyle: AppTextStyle.Grey16_757575,
                                constraints: BoxConstraints(maxHeight: 40),
                              ),
                              style: TextStyle(fontSize: 16),
                              // controller: controller.textEditingController,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SearchNormal(),
          ],
        ),
      ),
    );
  }

  buildSecondView(SearchingPageController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: (controller.animationTop?.value ?? 0) + 12,
                  bottom: 12,
                  left: 16,
                  right: 16),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    SizedBox(
                      width: Get.width - 32,
                      height: 40,
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: Get.width -
                            32 -
                            (controller.animationBtnWidth?.value ?? 0),
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.WHITE_EEEEEE, width: 0.0),
                            color: AppColors.WHITE_EEEEEE,
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.asset(LocalImages.asset('search')),
                              ),
                              Expanded(
                                child: TextField(
                                  textInputAction: TextInputAction.search,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autofocus: false,
                                  focusNode: controller.focusNode,
                                  onChanged: (value) {
                                    controller.search(value);
                                  },
                                  onSubmitted: (value) {
                                    controller.submit(value);
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(top: -9),
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle: AppTextStyle.Grey16_757575,
                                    constraints: BoxConstraints(maxHeight: 40),
                                  ),
                                  style: const TextStyle(fontSize: 16),
                                  controller: controller.textEditingController,
                                ),
                              ),
                              Visibility(
                                visible: controller
                                    .textEditingController.text.isNotEmpty,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.textEditingController.clear();
                                    controller.search('');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 11),
                                    child: Stack(
                                      children: [
                                        const SizedBox(
                                          width: 40,
                                          height: 40,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Center(
                                            child: Image.asset(
                                                LocalImages.asset('nav_close')),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: (controller.animationBtnWidth?.value ?? 0) - 70,
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 40,
                        padding: const EdgeInsets.only(left: 5),
                        child: GestureDetector(
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              Get.back();
                            });
                            controller.animationController?.reverse();
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.bodyViews
          ],
        ),
      ),
    );
  }
}
