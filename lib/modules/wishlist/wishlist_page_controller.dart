import 'package:get/get.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/data/services/wishlist/wishlist_service.dart';

class WishlistController extends GetxController with StateMixin<RxList> {
  static WishlistController get to => Get.find<WishlistController>();

  List<Product> productList = [];

  @override
  void onInit() {
    super.onInit();

    initData();
  }

  initData() async {
    productList = await WishlistService().getWishlistList();
    update();
  }

  removeProductFromWishlist(Product product) async {
    productList.remove(product);
    await WishlistService().removeProductFromWishlistList(product);
    update();
  }
}
