import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/category/model/category_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/search/search_category_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/list_item.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class SearchCategoryPage extends StatelessWidget {
  SearchCategoryPage({Key? key}) : super(key: key);

  final SearchCategoryPageController _controller =
      Get.put(SearchCategoryPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCategoryPageController>(
      init: _controller,
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: _controller.tags,
            actions: [CartPageController.to.cartView],
          ),
          body: SafeArea(
            child: ScrollConfiguration(
              behavior: NoScrollBehavior(),
              child: ListView(
                children: _buildItemList(_controller.categoryList),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildItemList(List<CategoryModel> categoryList) {
    return categoryList
        .map<Widget>(
          (category) => ListItem(
            text: category.name ?? '',
            color: category.name == 'Sale'
                ? AppColors.RED_CB0000
                : AppColors.BLACK,
            onTap: () {
              var tempCategoryName = category.name;
              if (tempCategoryName!.contains('All')) {
                tempCategoryName = '';
              }

              if (_controller.tags == 'Sale') {
                Get.toNamed(
                  AppRouters.productList,
                );
              } else {
                if (category.name == 'Sale') {
                  Get.toNamed(
                    AppRouters.productList,
                  );
                } else {
                  if (_controller.department == 'Kids') {
                    Get.toNamed(
                      AppRouters.productList,
                    );
                  } else {
                    Get.toNamed(
                      AppRouters.productList,
                    );
                  }
                }
              }
            },
          ),
        )
        .toList();
  }

  String formatUrl(String source) {
    source = source.toLowerCase();
    if (source == 'baby girls') {
      return 'baby-girl';
    } else if (source == 'baby boys') {
      return 'baby-boy';
    } else if (source == 'teen boys') {
      return 'teen-boy';
    } else if (source == 'teen girls') {
      return 'teen-girl';
    } else if (source == 'women') {
      return 'womens';
    } else if (source == 'men') {
      return 'mens';
    } else {
      return source;
    }
  }
}
