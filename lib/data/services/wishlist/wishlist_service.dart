import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class WishlistService {
  // ignore: constant_identifier_names
  static const WISHLIST = 'wishlist';

  Future<List<Product>> getWishlistList() async {
    var wishlist = await LocalStorage().getStorage(WISHLIST) ?? [];
    wishlist = wishlist.map<Product>((e) => Product.fromModelJson(e)).toList();
    return wishlist;
  }

  Future<bool> checkAddedWishlist(Product product) async {
    var isAddedWishlist = false;
    List localWishlist = await LocalStorage().getStorage(WISHLIST) ?? [];
    for (var element in localWishlist) {
      if (element['id'] == product.id) {
        isAddedWishlist = true;
        break;
      }
    }
    return isAddedWishlist;
  }

  addProductToWishlist(Product product) async {
    List localWishlist = await LocalStorage().getStorage(WISHLIST) ?? [];
    localWishlist.insert(0, product.toJson());
    await LocalStorage().setObject(WISHLIST, localWishlist);
  }

  removeProductFromWishlistList(Product product) async {
    List localWishlist = await LocalStorage().getStorage(WISHLIST) ?? [];
    for (var element in localWishlist) {
      if (element['id'] == product.id) {
        localWishlist.remove(element);
        break;
      }
    }
    await LocalStorage().setObject(WISHLIST, localWishlist);
  }

  removeAllWishlist() {
    LocalStorage().removeStorage(WISHLIST);
  }
}
