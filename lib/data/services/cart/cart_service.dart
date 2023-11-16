import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/cart_schema.dart';
import 'package:fox/data/model/cart/cart_model.dart';
import 'package:fox/data/model/enum/enum.dart';

class CartService {
  queryCart(String id, {LoadingType loadingType = LoadingType.display}) async {
    QueryResult response = await GQLProvider().client.query(
        schema: CartSchema.queryCart,
        variables: {'id': id},
        loadingType: loadingType);
    if (response.data?['cart'] != null) {
      var product = Cart.fromJson(response.data?['cart']);
      return product;
    } else {
      return null;
    }
  }

  createCart(String variantId) async {
    QueryResult response = await GQLProvider().client.mutate(
      schema: CartSchema.createCart,
      variables: {
        'input': {
          'lines': [
            {
              'quantity': 1,
              'merchandiseId': variantId,
            }
          ],
          'attributes': {
            'key': "cart_attribute",
            'value': "This is a cart attribute"
          }
        }
      },
    );
    var product = Cart.fromJson(response.data?['cartCreate']['cart']);
    return product;
  }

  addProductsToCart(String variantId, Cart cart) async {
    QueryResult response = await GQLProvider().client.mutate(
      schema: CartSchema.addProductsToCart,
      variables: {
        'cartId': cart.id,
        'lines': [
          {
            'quantity': 1,
            'merchandiseId': variantId,
          }
        ],
      },
    );
    var product = Cart.fromJson(response.data?['cartLinesAdd']['cart']);
    return product;
  }

  updateProductQuantityInCart(
      CartItem cartItem, Cart cart, int quantity) async {
    QueryResult response = await GQLProvider().client.mutate(
      schema: CartSchema.updateProductQuantityInCart,
      variables: {
        'cartId': cart.id,
        'lines': [
          {
            'quantity': quantity,
            'id': cartItem.id,
          }
        ],
      },
    );
    var product = Cart.fromJson(response.data?['cartLinesUpdate']['cart']);
    return product;
  }

  removeProductFromCart(CartItem cartItem, Cart cart) async {
    QueryResult response = await GQLProvider().client.mutate(
      schema: CartSchema.removeProductFromCart,
      variables: {
        'cartId': cart.id,
        'lineIds': [cartItem.id],
      },
    );
    var product = Cart.fromJson(response.data?['cartLinesRemove']['cart']);
    return product;
  }
}
