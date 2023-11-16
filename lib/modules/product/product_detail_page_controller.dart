// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/data/services/product/product_service.dart';
import 'package:fox/data/services/toast/toast_service.dart';
import 'package:fox/data/services/wishlist/wishlist_service.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/product/widget/product_detail_bottom_size.dart';
import 'package:fox/modules/wishlist/wishlist_page_controller.dart';
import 'package:fox/theme/styles/app_colors.dart';

class ProductDetailPageController extends GetxController {
  late Product productDetail;
  var pageStatus = PageStatus.loading;
  Variant? variant;
  var isAddedWishlist = false;
  var hasMultiSize = false;
  List<Product> recommendList = [];
  var productId = Get.arguments['id'].toString();

  @override
  void onInit() {
    super.onInit();
    getProductDetail();
    getRecommendList();
  }

  getProductDetail() async {
    try {
      var result = await ProductService().getProductDetail(productId);
      productDetail = result;
      if (productDetail.variants != null &&
          productDetail.variants!.isNotEmpty) {
        for (var element in productDetail.variants!) {
          if (element.isSoldOut == false) {
            variant = element;
            break;
          }
        }

        hasMultiSize = productDetail.variants!.length > 1;
      }
      isAddedWishlist =
          await WishlistService().checkAddedWishlist(productDetail);
      pageStatus = PageStatus.success;
      update();
    } catch (e) {
      print('error');
    }
  }

  getRecommendList() async {
    try {
      var result = await ProductService().getRecommendedList(productId);
      recommendList = result;
      update();
    } catch (e) {
      print(e);
    }
  }

  addToBag() async {
    if (variant == null) {
      ToastService().showToast('Please select a variant');
      return;
    }
    await CartPageController.to.addProductsToCart(variant?.id ?? '');
    ToastService().showToast('Already added to bag');
  }

  addWishlist() async {
    if (isAddedWishlist) {
      await WishlistService().removeProductFromWishlistList(productDetail);
    } else {
      await WishlistService().addProductToWishlist(productDetail);
    }
    isAddedWishlist = !isAddedWishlist;
    update();
    WishlistController.to.initData();
  }

  showModalBottomSheetPick() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            children: <Widget>[
              ProductDetailBottomSize(
                title: 'Please select your size',
                selectIndex: 0,
                pickItems: productDetail.variants,
                callback: (params) {
                  var index = params['index'];
                  variant = productDetail.variants?[index];
                  print(variant?.price);
                  update();
                },
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 200),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      barrierColor: Colors.black.withOpacity(0.4),
    );
  }
}
