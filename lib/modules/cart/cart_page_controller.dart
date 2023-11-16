import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/cart/cart_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/services/cart/cart_service.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class CartPageController extends GetxController {
  static CartPageController to = Get.find<CartPageController>();
  final RefreshController refreshController = RefreshController();
  Cart? cart;
  PageStatus pageStatus = PageStatus.loading;

  @override
  void onInit() {
    initCartData();
    super.onInit();
  }

  initCartData({LoadingType loadingType = LoadingType.none}) async {
    var cartId = await LocalStorage().getStorage(AppString.LOCALSTORAGE_CARTID);
    if (cartId != null) {
      await queryCart(cartId, loadingType: loadingType);
    }
    updatView();
  }

  queryCart(String cartId,
      {LoadingType loadingType = LoadingType.display}) async {
    cart = await CartService().queryCart(
      cartId,
      loadingType: loadingType,
    );
    if (cart == null) {
      LocalStorage().removeStorage(AppString.LOCALSTORAGE_CARTID);
    }
    updatView();
  }

  addProductsToCart(String variantId) async {
    if (cart != null) {
      cart = await CartService().addProductsToCart(variantId, cart!);
    } else {
      cart = await CartService().createCart(variantId);
      LocalStorage().setObject(AppString.LOCALSTORAGE_CARTID, cart?.id);
    }
    updatView();
  }

  updateProductQuantityInCart(CartItem cartItem, int quantity) async {
    cart = await CartService()
        .updateProductQuantityInCart(cartItem, cart!, quantity);
    updatView();
  }

  removeProductFromCart(CartItem cartItem) async {
    cart = await CartService().removeProductFromCart(cartItem, cart!);
    updatView();
  }

  onRefresh() async {
    try {
      await initCartData();
      refreshController.refreshCompleted(resetFooterState: true);
    } catch (e) {
      refreshController.refreshFailed();
    }
    updatView();
  }

  updatView() {
    if (cart?.cartItems != null && cart!.cartItems!.isNotEmpty) {
      pageStatus = PageStatus.normal;
    } else {
      pageStatus = PageStatus.empty;
    }
    update();
  }

  get cartView {
    return GetBuilder<CartPageController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 0),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.toNamed(AppRouters.cartPage);
            },
            splashRadius: 20,
            splashColor: AppColors.GREY_EEEEEE,
            highlightColor: AppColors.GREY_EEEEEE,
            icon: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset(LocalImages.asset('nav_bag')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    child: _text(cart?.totalQuantity ?? 0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _text(total) {
    String text = '$total';
    var width = 0.0;
    if (total == 0) {
      text = '';
    } else if (total > 99) {
      text = '+99   ';
    }
    if (total > 0 && total < 10) {
      width = 10.0;
    } else if (total >= 10 && total < 100) {
      width = 14.0;
    } else if (total >= 100) {
      width = 21.0;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: 10,
          color: Colors.white,
        ),
        Text(text, style: AppTextStyle.Black12),
      ],
    );
  }

  checkout() {
    Get.toNamed(AppRouters.checkoutPage, arguments: {'type': 'customer'});
  }

  applePay() {
    Get.toNamed(AppRouters.checkoutPage, arguments: {'type': 'web'});
  }
}
