import 'package:get/get.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/modules/wishlist/wishlist_page_controller.dart';

class MainPageController extends GetxController {
  int pageViewIndex = 0;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() {
    Get.lazyPut(() => CartPageController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ProfilePageController());
    Get.lazyPut(() => WishlistController());
    LoginController.to.initData();
  }
}
