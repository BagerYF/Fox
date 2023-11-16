import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/cart/cart_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/cart/widget/animated_list_item.dart';
import 'package:fox/modules/cart/widget/shopping_cart_select_quantity.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartPageController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.WHITE,
          appBar: CustomAppBar(
            showCloseButton: true,
            back: true,
            title: CartPageController.to.pageStatus == PageStatus.normal
                ? 'Shopping Bag (${CartPageController.to.cart?.totalQuantity ?? 0})'
                : 'Shopping Bag',
          ),
          body: buildBody(),
        );
      },
    );
  }

  Widget buildBody() {
    Widget body;
    switch (CartPageController.to.pageStatus) {
      case PageStatus.normal:
        body = buildNormalView();
        break;
      case PageStatus.empty:
        body = Container(
          alignment: Alignment.topCenter,
          child: Container(
              margin: const EdgeInsets.only(top: 269),
              child: const Text(
                "Your shopping cart is currently empty",
                style: AppTextStyle.Black16,
              )),
        );
        break;
      case PageStatus.loading:
        body = const Loading();
        break;
      default:
        body = const SizedBox();
    }
    return body;
  }

  Widget buildNormalView() {
    var bottomSafe = Get.context!.mediaQueryPadding.bottom;
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              controller: CartPageController.to.refreshController,
              onRefresh: () => CartPageController.to.onRefresh(),
              enablePullDown: true,
              enablePullUp: false,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    productList(),
                    reviewsAndFreeReturn(),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Divider(
                height: 1.0,
                color: AppColors.GREY_9E9E9E,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Subtotal',
                                    style: AppTextStyle.Black14,
                                  )),
                              Text(
                                '${CartPageController.to.cart?.cost?.subtotalAmount?.currencyCode ?? ''} ${CartPageController.to.cart?.cost?.subtotalAmount?.amount ?? ''}',
                                style: AppTextStyle.Black14,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                            ],
                          ),
                        ),
                        const Text('Shipping and taxes calculated at checkout',
                            style: AppTextStyle.Black12),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              buildBottomButtons(),
              SizedBox(
                height: bottomSafe == 0 ? 24 : bottomSafe + 12,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget productList() {
    List<CartItem> cartItems = CartPageController.to.cart?.cartItems ?? [];
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: cartItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            GlobalKey<ListItemState> globalKey = GlobalKey<ListItemState>();
            return AnimatedListItem(
              index,
              listItem(cartItems[index], globalKey),
              (position) {},
              key: globalKey,
            );
          }),
    );
  }

  Widget listItem(CartItem cartItem, GlobalKey<ListItemState> globalKey) {
    bool isSoldOut =
        cartItem.quantity! > cartItem.merchandise!.quantityAvailable!;
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              Container(
                margin: const EdgeInsets.only(left: 16, right: 21),
                color: Colors.white,
                width: 104,
                height: 139,
                child: CachedNetworkImage(
                    imageUrl: cartItem.merchandise?.url ??
                        'https://img2.baidu.com/it/u=1585458193,188380332&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500'),
              ),
              //product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Vendor  Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  cartItem.merchandise?.productType ?? '',
                                  style: isSoldOut
                                      ? AppTextStyle.Grey12_757575
                                      : AppTextStyle.Black14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                cartItem.merchandise?.productTitle ?? '',
                                style: isSoldOut
                                    ? AppTextStyle.Grey14_757575
                                    : AppTextStyle.Black14,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        //remove cart item
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            globalKey.currentState?.slidToRemove();
                            CartPageController.to
                                .removeProductFromCart(cartItem);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, right: 19),
                            child: Image.asset(
                              LocalImages.asset('cart_delete_product'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //size color
                    Row(
                      children: [
                        Text(
                          cartItem.merchandise?.title ?? '',
                          style: AppTextStyle.Grey14_757575,
                        ),
                      ],
                    ),

                    //Qty
                    if (!isSoldOut)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          //Qty
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                ShoppingCartSelectQuantity(
                                  selectIndex: cartItem.quantity,
                                  inventoryAvailableToSell:
                                      cartItem.merchandise?.quantityAvailable ??
                                          1,
                                  callback: (quantity) {
                                    CartPageController.to
                                        .updateProductQuantityInCart(
                                            cartItem, quantity);
                                  },
                                ),
                                barrierColor: Colors.black.withOpacity(0.4),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                              alignment: Alignment.center,
                              width: 100,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.WHITE_EEEEEE,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: Border.all(
                                    width: 1, color: AppColors.WHITE_EEEEEE),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Qty ',
                                        style: AppTextStyle.Grey14_757575,
                                        strutStyle: StrutStyle(
                                          fontSize: 14,
                                          height: 1.1,
                                          leading: 0,
                                          forceStrutHeight: true,
                                        ),
                                      ),
                                      Text(
                                        '${cartItem.quantity ?? 1}',
                                        style: AppTextStyle.Black14,
                                        strutStyle: const StrutStyle(
                                          fontSize: 14,
                                          height: 1.1,
                                          leading: 0,
                                          forceStrutHeight: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    LocalImages.asset('porduct_detail_arrow'),
                                    width: 16,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),

          //Move to wishlist
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  globalKey.currentState?.slidToRemove();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 16),
                  child: Container(
                    width: 125,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Move to wishlist',
                      style: AppTextStyle.Grey12_757575,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: isSoldOut
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'See related items',
                                style: AppTextStyle.Grey12_757575,
                              ),
                            ),
                          ),
                          const Text(
                            'Out of Stock',
                            style: TextStyle(
                                color: AppColors.GREY_9E9E9E,
                                fontFamily: AppTextStyle.BASEL_GROTESK,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 6,
                            backgroundImage: AssetImage(
                              LocalImages.asset('icon_cart_stock_big'),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price',
                            style: AppTextStyle.Grey12_757575,
                          ),
                          Text(
                            '${cartItem.cost?.totalAmount?.currencyCode ?? ''} ${cartItem.cost?.totalAmount?.amount ?? 0}',
                            style: AppTextStyle.BlackBold12,
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 24),
            child: const Divider(
              height: 1,
              color: AppColors.GREY_9E9E9E,
              indent: 16,
              endIndent: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget reviewsAndFreeReturn() {
    var isFreeReturn = true;
    return Container(
      padding: const EdgeInsets.only(top: 25),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          reviewsItem(
              'cart_icon_review',
              'Reviews',
              'See what our customers \n have to say about \n shopping with us',
              'See Our Reviews'),
          reviewsItem(
              'cart_icon_free_return',
              // ignore: dead_code
              isFreeReturn ? 'Free returns' : 'Easy returns',
              isFreeReturn
                  ? 'Shop in confidence with \n free returns available on \n every order'
                  // ignore: dead_code
                  : 'Shop in confidence with \n a quick and easy return \n process',
              'Return Policy'),
        ],
      ),
    );
  }

  Widget reviewsItem(
      String img, String type, String description, String action) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 82),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {},
              child: Column(
                children: [
                  Image.asset(
                    LocalImages.asset(img),
                    width: 24,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    type,
                    style: AppTextStyle.BlackBold14,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      height: 58,
                      child: Text(
                        description,
                        style: AppTextStyle.Grey12_757575,
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(height: 8),
                  Text(action,
                      style: const TextStyle(
                        color: AppColors.GREY_9E9E9E,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 8),
            height: 40,
            child: OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(color: AppColors.BLACK, width: 1)),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(2.0),
                ))),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white10;
                  }
                  return AppColors.WHITE;
                }),
              ),
              onPressed: () {
                CartPageController.to.applePay();
              },
              child: Align(
                child:
                    Image.asset(LocalImages.asset('product_detail_apple_pay')),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(left: 8, right: 16),
            child: OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => AppColors.WHITE),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey[600];
                  }
                  return AppColors.BLACK;
                }),
              ),
              onPressed: () async {
                CartPageController.to.checkout();
              },
              child: const Align(
                child: Text(
                  'Checkout',
                  style: AppTextStyle.WhiteBold14,
                ),
              ),
            ),
          ),
        ),
      ],
      // ),
    );
  }
}
