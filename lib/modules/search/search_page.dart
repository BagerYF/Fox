import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/search/search_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';

class SearchPage extends StatelessWidget {
  final SearchPageController controller = Get.put(SearchPageController());

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return GetBuilder<SearchPageController>(
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: controller.showNav
              ? CustomAppBar(
                  title: 'Search',
                  actions: [CartPageController.to.cartView],
                )
              : null,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouters.searching);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 16, right: 16),
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
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              textCapitalization: TextCapitalization.sentences,
                              autofocus: false,
                              enabled: false,
                              focusNode: focusNode,
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
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              controller.bodyViews
            ],
          ),
        );
      },
    );
  }
}
