import 'package:get/get.dart';
import 'package:fox/modules/cart/cart_page.dart';
import 'package:fox/modules/chat/chat_page.dart';
import 'package:fox/modules/checkout/checkout_page.dart';
import 'package:fox/modules/designers/designers_list_page.dart';
import 'package:fox/modules/designers/designers_page.dart';
import 'package:fox/modules/error/network_page.dart';
import 'package:fox/modules/error/server_error_page.dart';
import 'package:fox/modules/login/login_page.dart';
import 'package:fox/modules/main/main_page.dart';
import 'package:fox/modules/product/product_detail_page.dart';
import 'package:fox/modules/product/product_list_page.dart';
import 'package:fox/modules/profile/address/country/checkout_country_page.dart';
import 'package:fox/modules/profile/address/province/checkout_province_page.dart';
import 'package:fox/modules/profile/address/saved_address_detail_page.dart';
import 'package:fox/modules/profile/address/saved_address_page.dart';
import 'package:fox/modules/profile/blog/blog_detail_page.dart';
import 'package:fox/modules/profile/blog/blog_list_page.dart';
import 'package:fox/modules/profile/faq/faq_page.dart';
import 'package:fox/modules/profile/help_and_contacts/help_and_contacts_page.dart';
import 'package:fox/modules/profile/notifications/notifications_page.dart';
import 'package:fox/modules/profile/order/order_detail_page.dart';
import 'package:fox/modules/profile/order/order_page.dart';
import 'package:fox/modules/profile/profile_page.dart';
import 'package:fox/modules/profile/region/region_page.dart';
import 'package:fox/modules/profile/security_and_password/security_and_password_page.dart';
import 'package:fox/modules/profile/widget/about.dart';
import 'package:fox/modules/profile/widget/privacy_policy.dart';
import 'package:fox/modules/profile/widget/return_and_refunds.dart';
import 'package:fox/modules/profile/widget/terms_and_conditions.dart';
import 'package:fox/modules/search/search_category_page.dart';
import 'package:fox/modules/search/search_page.dart';
import 'package:fox/modules/search/searching_page.dart';

class AppRouters {
  static const String main = "/";
  static const String networkPage = "/networkPage";
  static const String productList = "/productList";
  static const String serverErrorPage = "/serverErrorPage";
  static const String productDetail = "/productDetail";
  static const String cartPage = "/cartPage";
  static const String designersPageList = "/designersPageList";
  static const String designers = "/designers";
  static const String search = "/search";
  static const String searching = "/searching";
  static const String searchCategoryPage = "/search_category_page";
  static const String profile = '/profile';
  static const String orderPage = '/profile/order_page';
  static const String orderDetailPage = '/profile/order_detail';
  static const String profileLocalOrders = '/profile/localOrders';
  static const String profileSecurityAndPassword =
      '/profile/SecurityAndPassword';
  static const String savedAddressPage = '/savedAddressPage';
  static const String savedAddressDetailPage = '/savedAddressDetailPage';
  static const String localAddressPage = '/localAddressPage';
  static const String localAddressDetailPage = '/localAddressDetailPage';
  static const String profileRegion = '/profile/Region';
  static const String profileNotifications = '/profile/notifications';
  static const String profileAbout = '/profile/about';
  static const String profileHelpAndContacts = '/profile/helpAndContacts';
  static const String profileFAQ = '/profile/FAQ';
  static const String profileReturnAndRefunds = '/profile/returnAndRefunds';
  static const String termsAndConditions = '/termsAndConditions';
  static const String privacyPolicy = '/privacyPolicy';
  static const String checkoutCountryPage = '/checkout_country_page';
  static const String checkoutProvincePage = '/checkout_province_page';
  static const String loginPage = '/loginPage';
  static const String checkoutPage = '/checkout_page';
  static const String chatPage = '/chatPage_page';
  static const String blogListPage = '/blogListPage';
  static const String blogDetailPage = '/blogDetailPage';

  static final List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () => MainPage(),
    ),
    GetPage(
      name: productList,
      preventDuplicates: false,
      page: () => ProductListPage(),
    ),
    GetPage(
      name: productDetail,
      preventDuplicates: false,
      page: () => ProductDetailPage(),
    ),
    GetPage(
      name: cartPage,
      page: () => const CartPage(),
      fullscreenDialog: true,
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),
    GetPage(
      name: networkPage,
      page: () => NetworkPage(),
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(
        milliseconds: 0,
      ),
    ),
    GetPage(
      name: serverErrorPage,
      page: () => ServerErrorPage(),
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(
        milliseconds: 0,
      ),
    ),
    GetPage(
      name: designersPageList,
      page: () => const DesignersListPage(),
    ),
    GetPage(
      name: designers,
      page: () => const DesignersPage(),
    ),
    GetPage(
      name: searchCategoryPage,
      page: () => SearchCategoryPage(),
    ),
    GetPage(
      name: search,
      page: () => SearchPage(),
    ),
    GetPage(
      name: searching,
      page: () => SearchingPage(),
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(
        milliseconds: 0,
      ),
    ),
    GetPage(
      name: profileSecurityAndPassword,
      page: () => SecurityAndPasswordPage(),
    ),
    GetPage(
      name: savedAddressPage,
      page: () => SavedAddressPage(),
    ),
    GetPage(
      name: savedAddressDetailPage,
      page: () => SavedAddressDetailPage(),
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: profileRegion,
      page: () => RegionPage(),
    ),
    GetPage(
      name: profileNotifications,
      page: () => NotificationsPage(),
    ),
    GetPage(
      name: profileAbout,
      page: () => const About(),
    ),
    GetPage(
      name: profileHelpAndContacts,
      page: () => HelpAndContactsPage(),
    ),
    GetPage(
      name: profileFAQ,
      page: () => Faq(),
    ),
    GetPage(
      name: profileReturnAndRefunds,
      page: () => ReturnAndRefunds(),
    ),
    GetPage(
      name: termsAndConditions,
      page: () => TermsAndConditions(),
    ),
    GetPage(
      name: privacyPolicy,
      page: () => PrivacyPolicy(),
    ),
    GetPage(
      name: checkoutCountryPage,
      page: () => CheckoutCountryPage(),
      fullscreenDialog: true,
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),
    GetPage(
      name: checkoutProvincePage,
      page: () => CheckoutProvincePage(),
      fullscreenDialog: true,
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),
    GetPage(
      name: loginPage,
      page: () => LoginPage(),
      fullscreenDialog: true,
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),
    GetPage(
      name: checkoutPage,
      page: () => CheckoutPage(),
    ),
    GetPage(
      name: orderPage,
      page: () => OrderPage(),
    ),
    GetPage(
      name: orderDetailPage,
      page: () => OrderDetailPage(),
    ),
    GetPage(
      name: chatPage,
      page: () => ChatPage(),
      fullscreenDialog: true,
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    ),
    GetPage(
      name: blogListPage,
      page: () => BlogListPage(),
    ),
    GetPage(
      name: blogDetailPage,
      page: () => BlogDetailPage(),
    ),
  ];
}
