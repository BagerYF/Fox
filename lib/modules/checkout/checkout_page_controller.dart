import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fox/config/config.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/address/country_map.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/cart/cart_model.dart';
import 'package:fox/data/model/checkout/checkout_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/data/model/input/input_model.dart';
import 'package:fox/data/services/checkout/checkout_service.dart';
import 'package:fox/data/services/loading/loading_service.dart';
import 'package:fox/data/services/localization/localization_service.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/tools/postcode_validate/postcode_validate.dart';
import 'package:fox/utils/widget/network_image.dart';
import 'package:fox/utils/widget/rounded_loading_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum CheckoutResultType {
  checkoutResultProcessing,
  checkoutResultSuccess,
  checkoutResultFail,
}

class CheckoutPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  // view
  final addressFormKey = GlobalKey<FormState>();
  final worldPayFormKey = GlobalKey<FormState>();
  final checkoutPayFormKey = GlobalKey<FormState>();
  final ewayPayFormKey = GlobalKey<FormState>();
  final billingAddressFormKey = GlobalKey<FormState>();
  final giftCardFormKey = GlobalKey<FormState>();
  late TabController tabController;
  var webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  var checkoutType = Get.arguments['type'] ?? 'web';

  var showIntro = false;
  bool creditCardError = false;
  String creditCardErrorMessage =
      'Your payment details couldn’t be verified. Check your card details and try again.';
  PageStatus pageStatus = PageStatus.init;

  var typeList = [
    'Address',
    'Delivery',
    'Payment',
  ];
  var emailTitleList = [
    ['Email']
  ];
  var addressInputTitleList = [
    ['First Name'],
    ['Last Name'],
    ['Country'],
    ['Address'],
    ['Apartment, Suite, Unit, Building'],
    ['City'],
    ['State', 'Postcode / Zipcode'],
    ['Phone'],
  ];
  var payInputTitleList = [
    ['Card Number'],
    ['MM/YY', ' '],
    ['Name on Card'],
    ['CVV', '  ']
  ];
  var codeInputTitleList = [
    ['Gift card or discount code']
  ];
  List<List<InputItemModel>> emailInputList = [];
  List<List<InputItemModel>> addressInputList = [];
  List<List<InputItemModel>> worldpayInputList = [];
  List<List<InputItemModel>> checkoutPayInputList = [];
  List<List<InputItemModel>> ewayPayInputList = [];
  List<List<InputItemModel>> codeInputList = [];
  List<AddressModel> addressList = [];

  // data
  Cart? cart;
  Checkout? checkout;
  bool isLogin = LoginController.to.isLogin;
  String placeOrderError = '';

  //shipping address
  List<Country> countryList = [];
  List<Provinces> provincesList = [];
  late Country selectCountry;
  Provinces? selectProvince;
  bool rememberAddress = true;

  List<Country> billCountryList = [];

  bool sameAsShippingAddress = true;

  AddressModel? selectShippingAddress;
  late AddressModel selectBillingAddress;
  bool showAddressList = false;
  bool emailSubscribe = true;

  String? mirrorCartId;
  String? afterPayToken;

  //gift card or discount code
  TextEditingController giftCardController = TextEditingController();
  String? giftCardErrorMessage;
  GlobalKey errorMessageGlobalKey = GlobalKey();
  var discountCode = '';
  var discountValue = 0.0;

  final isShowApply = false.obs;
  var errorMsg = 'We’re sorry, we do not currently delivery to this region';

  late StreamSubscription<bool> keyboardSubscription;

  var showKeyboard = false;

  showApply(String text) {
    isShowApply.value = text.isNotEmpty;
    if (giftCardErrorMessage != null) {
      giftCardErrorMessage = null;
      giftCardFormKey.currentState?.validate();
      update();
    }
  }

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  List<FocusNode> focusNodePays = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void onInit() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      showKeyboard = visible;
      update();
      Future.delayed(const Duration(milliseconds: 200))
          .whenComplete(() => update());
      // update();
    });
    if (Get.arguments?['errorMsg'] != null) {
      errorMsg = Get.arguments?['errorMsg'];
      pageStatus = PageStatus.error;
      update();
    } else if (Get.arguments?['successMsg'] != null) {
      pageStatus = PageStatus.success;
      update();
    } else {
      initData();

      webViewController.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('${EnvironmentConfig.baseUrl}/account/logout')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    }
    super.onInit();
    debounce(
      isShowApply,
      (value) {
        update();
      },
      time: const Duration(milliseconds: 600),
    );
  }

  @override
  void onClose() {
    keyboardSubscription.cancel();
    var allInputList = [
      emailInputList,
      addressInputList,
      worldpayInputList,
      checkoutPayInputList,
      ewayPayInputList,
      codeInputList,
    ];

    for (var inputList in allInputList) {
      for (var items in inputList) {
        for (var i in items) {
          i.controller?.dispose();
        }
      }
    }

    super.onClose();
  }

  initData() async {
    tabController = TabController(length: typeList.length, vsync: this);
    emailInputList = getInputItemModelList(emailTitleList);
    addressInputList = getInputItemModelList(addressInputTitleList);
    worldpayInputList = getInputItemModelList(payInputTitleList);
    checkoutPayInputList = getInputItemModelList(payInputTitleList);
    ewayPayInputList = getInputItemModelList(payInputTitleList);
    codeInputList = getInputItemModelList(codeInputTitleList);
    initAddress();
    initCheckout();
  }

  initAddress() async {
    billCountryList = kCountryMaps.map((v) => Country.fromJson(v)).toList();

    var tempCountryList = kCountryMaps.map((v) => Country.fromJson(v)).toList();
    var localizationList = await LocalizationService().getLocalizationList();
    for (var local in localizationList) {
      for (var country in tempCountryList) {
        if (country.code == local.isoCode) {
          countryList.add(country);
          break;
        }
      }
    }

    var tCountryList = countryList
        .where(
            (element) => element.code == ProfilePageController.to.region.code)
        .toList();
    if (tCountryList.isNotEmpty) {
      selectCountry = tCountryList[0];
      setCountryData();
      provincesList = selectCountry.provinces ?? [];
    }

    var address = await CheckoutService().getShippingAddress();
    if (address != null) {
      formateAddressData(address);
    }
  }

  initCheckout() async {
    cart = CartPageController.to.cart;
    var params = {
      'lineItems': cart?.cartItems
          ?.map((e) => {'variantId': e.merchandise?.id, 'quantity': e.quantity})
          .toList(),
    };

    checkout = await CheckoutService.checkoutCreate(params: params);
    if (checkoutType == 'customer') {
      pageStatus = PageStatus.normal;
    } else {
      webViewController.loadRequest(Uri.parse(checkout?.webUrl ?? ''),
          headers: {
            'X-Shopify-Customer-Access-Token':
                LoginController.to.token?.accessToken ?? ''
          });
      pageStatus = PageStatus.webview;
    }

    update();
  }

  getInputItemModelList(List<List<String>> titleList) {
    List<List<InputItemModel>> tempAllList = [];
    for (var item in titleList) {
      List<InputItemModel> tempList = [];
      for (var i in item) {
        InputItemModel addressItem = InputItemModel.fromJson({
          'show': true,
          'name': i,
          'controller': TextEditingController(text: ''),
          'optional': (i == 'Apartment, Suite, Unit, Building' || i == 'Phone')
              ? true
              : false,
          'titleTextStyle': i == 'Gift card or discount code'
              ? AppTextStyle.BlackBold12
              : AppTextStyle.Black12,
          'showTitle':
              titleList.length == payInputTitleList.length ? false : true,
          if (i == 'Country') 'onTap': selectCountries,
          if (i == 'State') 'onTap': selectProvinces,
          'key': GlobalKey(),
          if (i == 'Country' || i == 'State')
            'suffixIcon': Container(
              margin: const EdgeInsets.only(top: 16, right: 5),
              child: Image.asset(
                LocalImages.asset('arrow_down'),
              ),
            ),
        });
        if (i == 'First Name') {
          addressItem.errorMsg = 'Enter a First name';

          addressItem.focusNode = focusNodes[0];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Last Name') {
          addressItem.errorMsg = 'Enter a Last name';

          addressItem.focusNode = focusNodes[1];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Email') {
          addressItem.invalidEmail = true;
          addressItem.errorMsg = 'Enter a valid email';

          addressItem.placeorderName = 'Email Address';
          addressItem.textInputType = TextInputType.emailAddress;

          addressItem.focusNode = focusNodes[2];
        }
        if (i == 'Address') {
          addressItem.errorMsg = 'Enter an address';
          addressItem.focusNode = focusNodes[3];
          addressItem.textInputAction = TextInputAction.next;
          addressItem.placeorderName = 'Street Address';
        }
        if (i == 'Apartment, Suite, Unit, Building') {
          addressItem.focusNode = focusNodes[4];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'City') {
          addressItem.errorMsg = 'Enter a city';

          addressItem.focusNode = focusNodes[5];
        }
        if (i == 'Postcode / Zipcode') {
          addressItem.errorMsg = 'Enter a ZIP / postal code';

          addressItem.placeorderName = 'Postcode';
          addressItem.focusNode = focusNodes[6];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Phone') {
          addressItem.placeorderName = 'Phone number';
          addressItem.focusNode = focusNodes[7];
        }
        if (i == ' ') {
          addressItem.isEmpty = true;
          addressItem.onTap = () {};
          addressItem.lineColor = Colors.white;
        }
        if (i == '  ') {
          addressItem.isEmpty = true;
          addressItem.onTap = () {};
          addressItem.lineColor = Colors.white;
          addressItem.prefixIcon = Container(
            margin: const EdgeInsets.only(top: 14),
            child: Image.asset(
              LocalImages.asset('credit'),
            ),
          );
        }
        if (i == 'Card Number') {
          addressItem.controller =
              MaskedTextController(mask: '0000 0000 0000 0000');
          addressItem.keyboardIsNum = true;
          addressItem.textInputType = TextInputType.number;
          addressItem.focusNode = focusNodePays[0];
          addressItem.errorMsg = 'Card number should be at least 10 digits';
        }
        if (i == 'MM/YY') {
          addressItem.controller = MaskedTextController(mask: '00/0000');
          addressItem.keyboardIsNum = true;
          addressItem.textInputType = TextInputType.number;
          addressItem.focusNode = focusNodePays[1];
          addressItem.errorMsg = 'Enter a valid card expiry date';

          addressItem.placeorderName = 'MM / YY';
        }

        if (i == 'Name on Card') {
          addressItem.focusNode = focusNodePays[2];
        }

        if (i == 'CVV') {
          addressItem.keyboardIsNum = true;
          addressItem.textInputType = TextInputType.number;
          addressItem.focusNode = focusNodePays[3];
          addressItem.maxLength = 4;
          addressItem.errorMsg = 'Security code is invalid';

          addressItem.placeorderName = 'Security code';
        }
        tempList.add(addressItem);
      }
      tempAllList.add(tempList);
    }
    return tempAllList;
  }

  next() async {
    if (tabController.index == 0) {
      addressInputList[6][1].forceInvalidate = false;
      addressInputList[6][1].errorMsg = 'Enter a ZIP / postal code';
      var result = addressFormKey.currentState?.validate();
      if (result == false) {
        var resultValidate = await PostcodeValidate().checkPostCode(
            selectCountry.code, addressInputList[6][1].controller?.text);
        if (resultValidate.length > 0) {
          addressInputList[6][1].forceInvalidate = true;
          addressInputList[6][1].errorMsg = resultValidate;
          addressFormKey.currentState?.validate();
          update();
        }
        for (var item in emailInputList) {
          for (var i in item) {
            if (i.controller!.text.trim().isEmpty) {
              Scrollable.ensureVisible(i.key!.currentContext!);
              return;
            }
          }
        }
        for (var item in addressInputList) {
          for (var i in item) {
            if (i.controller!.text.trim().isEmpty) {
              Scrollable.ensureVisible(i.key!.currentContext!);
              return;
            }
          }
        }
      } else {
        var resultValidate = await PostcodeValidate().checkPostCode(
            selectCountry.code, addressInputList[6][1].controller?.text);
        if (resultValidate.length > 0) {
          addressInputList[6][1].forceInvalidate = true;
          addressInputList[6][1].errorMsg = resultValidate;
          Scrollable.ensureVisible(addressInputList[6][1].key!.currentContext!);
          addressFormKey.currentState?.validate();
          update();
          return;
        }
        updateShippingAddressModel();
      }
      // next
      btnController.start();
      saveShippingAddressToLocal();
      await checkoutShippingAddressUpdate();
      await checkoutShippingLines();
      btnController.reset();
      tabController.index = 1;
    } else if (tabController.index == 1) {
      if (sameAsShippingAddress) {
        selectBillingAddress =
            AddressModel.fromJson(selectShippingAddress!.toJson());
      }

      tabController.index = 2;
    } else if (tabController.index == 2) {
      creditCardError = false;
      creditCardErrorMessage =
          'Your payment details couldn’t be verified. Check your card details and try again.';

      for (var element in worldpayInputList) {
        for (var item in element) {
          item.forceInvalidate = false;
        }
      }

      worldpayInputList[1][1].controller!.text = ' ';
      worldpayInputList[3][1].controller!.text = '  ';

      checkoutPayInputList[1][1].controller!.text = ' ';
      checkoutPayInputList[3][1].controller!.text = '  ';

      ewayPayInputList[1][1].controller!.text = ' ';
      ewayPayInputList[3][1].controller!.text = '  ';
      update();

      btnController.start();

      await checkoutCustomerAssociate();
      if ((double.parse(checkout?.totalPriceV2?.amount ?? '')) == 0) {
        await checkoutCompleteFree();
      } else {
        // price > 0 to do
      }

      btnController.reset();

      pageStatus = PageStatus.success;
    }
    update();
  }

  selectCountries() async {
    List<Country> arguments;
    arguments = countryList;

    var result =
        await Get.toNamed(AppRouters.checkoutCountryPage, arguments: arguments);
    if (result != null) {
      selectCountry = result as Country;
      for (var item in countryList) {
        if (item.code == selectCountry.code) {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
      setCountryData();
      provincesList = selectCountry.provinces ?? [];
      if (provincesList.isNotEmpty) {
        selectProvince = null;
        addressInputList[6][0].controller!.text = '';
        addressInputList[6][0].show = true;
      } else {
        selectProvince = null;
        addressInputList[6][0].controller!.text = '';
        addressInputList[6][0].show = false;
      }

      for (var item in provincesList) {
        item.selected = false;
      }

      update();
    }
  }

  selectProvinces() async {
    List<Provinces> arguments;
    arguments = provincesList;
    var result = await Get.toNamed(AppRouters.checkoutProvincePage,
        arguments: arguments);
    if (result != null) {
      selectProvince = result as Provinces;
      for (var item in provincesList) {
        if (item.code == selectProvince?.code) {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
      addressInputList[6][0].controller!.text =
          getThumbnailString(selectProvince!.name!);

      update();
    }
  }

  prepareToPlaceOrder({String? klarnaToken}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    btnController.start();

    var encryptData = '';

    String date = worldpayInputList[1][0].controller!.text;
    var split = date.split('/');
    if (split.length < 2) {
      creditCardError = true;
      worldpayInputList[1][0].forceInvalidate = true;
      update();
      btnController.reset();
      return;
    }
    String year = split[1];
    if (year.length == 2) {
      year = '20$year';
    }
    DateTime expiryDate =
        DateTime(int.tryParse(year) ?? 1, int.tryParse(split[0]) ?? 1);
    DateTime nowDate = DateTime.now().subtract(const Duration(days: 30));

    if (worldpayInputList[0][0].controller!.text.length < 10) {
      creditCardError = true;
      worldpayInputList[0][0].forceInvalidate = true;
      btnController.reset();
      LoadingService().dismiss();
    }

    if (expiryDate.isBefore(nowDate) || (int.tryParse(split[0]) ?? 13) > 12) {
      creditCardError = true;
      worldpayInputList[1][0].forceInvalidate = true;
      btnController.reset();
      LoadingService().dismiss();
    }
    if (worldpayInputList[3][0].controller!.text.length < 3) {
      creditCardError = true;
      worldpayInputList[3][0].forceInvalidate = true;
      btnController.reset();
      LoadingService().dismiss();
    }
    if (creditCardError) {
      update();
      Future.delayed(const Duration(microseconds: 500)).whenComplete(() {
        Scrollable.ensureVisible(errorMessageGlobalKey.currentContext!);
      });
      return;
    }

    try {
      LoadingService().show(LoadingType.transparent);
      if (encryptData.startsWith("error")) {
        LoadingService().dismiss();
        btnController.reset();
        creditCardError = true;

        update();
        Scrollable.ensureVisible(errorMessageGlobalKey.currentContext!);

        return;
      }
    } catch (e) {
      LoadingService().dismiss();
      btnController.reset();
      creditCardError = true;

      update();
      Future.delayed(const Duration(microseconds: 500)).whenComplete(() {
        Scrollable.ensureVisible(errorMessageGlobalKey.currentContext!);
      });

      return;
    }
  }

  inventoryQuery({LoadingType loadingType = LoadingType.none}) async {}

  showOutOfStock() async {}

  getErrorMessage() {
    var finalMessage =
        "There are some issues regarding to your payment info, please try again or contact our supports if needed.";
    return finalMessage;
  }

  checkoutCustomerAssociate({
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    if (LoginController.to.token?.accessToken != null) {
      checkout = await CheckoutService.checkoutCustomerAssociate(
        params: {
          'checkoutId': checkout?.id,
          'customerAccessToken': LoginController.to.token?.accessToken,
        },
        loadingType: loadingType,
      );
      update();
    }
  }

  checkoutShippingAddressUpdate() async {
    checkout = await CheckoutService.checkoutShippingAddressUpdate(params: {
      'checkoutId': checkout?.id,
      'shippingAddress': selectShippingAddress?.toJson(),
    });
  }

  Future<bool> checkoutShippingLines() async {
    var tempCheckout = await CheckoutService.checkoutShippingLines(params: {
      'id': checkout?.id,
    });
    checkout?.availableShippingRates = tempCheckout.availableShippingRates;
    if (checkout?.availableShippingRates?.ready == true) {
      return true;
    }
    return await checkoutShippingLines();
  }

  checkoutShippingLineUpdate(
    ShippingRates shippingRate, {
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    checkout = await CheckoutService.checkoutShippingLineUpdate(
      params: {
        'checkoutId': checkout?.id,
        'shippingRateHandle': shippingRate.handle,
      },
      loadingType: loadingType,
    );
    update();
  }

  saveShippingAddressToLocal() {
    var tempShippingAddress =
        AddressModel.fromJson(selectShippingAddress!.toJson());
    tempShippingAddress.email = emailInputList[0][0].controller!.text;

    if (rememberAddress) {
      CheckoutService().setShippingAddress(tempShippingAddress);
    }
  }

  applyDiscountCodeOrGiftCardToCart() async {
    var code = giftCardController.text.trim();
    if (code.isNotEmpty) {
      giftCardErrorMessage = null;
      try {
        checkout = await CheckoutService.checkoutDiscountCodeApplyV2(
          params: {
            'checkoutId': checkout?.id,
            'discountCode': code,
          },
          loadingType: LoadingType.display,
        );
        discountCode = code;
        giftCardController.clear();
        updateGiftAndDiscounts();
      } on ExceptionModel catch (e) {
        if (e.type == ExceptionType.back) {
        } else if (e.type == ExceptionType.retry) {
        } else if (e.type == ExceptionType.server) {
          giftCardErrorMessage = 'Enter a valid discount code or gift card';
          giftCardFormKey.currentState?.validate();
          update();
        }
        return;
      }
    } else {
      giftCardErrorMessage = 'Enter a valid discount code or gift card';
      giftCardFormKey.currentState?.validate();
      update();
    }
  }

  deleteDiscountCodeOrGiftCard() async {
    checkout = await CheckoutService.checkoutDiscountCodeRemove(
      params: {
        'checkoutId': checkout?.id,
      },
      loadingType: LoadingType.display,
    );
    discountCode = '';
    updateGiftAndDiscounts();
  }

  updateGiftAndDiscounts() {
    var lineItemsSubtotalPrice =
        double.parse(checkout?.lineItemsSubtotalPrice?.amount ?? '');
    var subtotalPriceV2 = double.parse(checkout?.subtotalPriceV2?.amount ?? '');
    discountValue = lineItemsSubtotalPrice - subtotalPriceV2;
    update();
  }

  checkoutCompleteFree({
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    checkout = await CheckoutService.checkoutCompleteFree(
      params: {
        'checkoutId': checkout?.id,
      },
      loadingType: loadingType,
    );
    update();
  }

  checkoutCompleteWithCreditCard({
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    checkout = await CheckoutService.checkoutCompleteWithCreditCard(
      params: {
        'checkoutId': checkout?.id,
        "payment": {
          "billingAddress": selectBillingAddress.toJson(),
          "idempotencyKey": "",
          "paymentAmount": {
            "amount": checkout?.totalPriceV2?.amount,
            "currencyCode": checkout?.totalPriceV2?.currencyCode
          },
          "test": true,
          "vaultId": ""
        }
      },
      loadingType: loadingType,
    );
    update();
  }

  checkoutCompleteWithUrl() async {}

  editBillingAddress() async {
    var result = await Get.toNamed(
      AppRouters.savedAddressDetailPage,
      arguments: {
        'billingAddress': true,
        'addressModel': selectBillingAddress,
        'countryList': billCountryList,
      },
    );
    if (result != null) {
      // no same
      selectBillingAddress = result;
      sameAsShippingAddress =
          await compareAddress(selectShippingAddress!, selectBillingAddress);
      update();
    }
  }

  formateAddressData(AddressModel address) {
    emailInputList[0][0].controller!.text = 'shopify@gmail.com';
    addressInputList[0][0].controller!.text = address.firstName ?? '';
    addressInputList[1][0].controller!.text = address.lastName ?? '';
    addressInputList[3][0].controller!.text = address.address1 ?? '';
    addressInputList[4][0].controller!.text = address.address2 ?? '';
    addressInputList[5][0].controller!.text = address.city ?? '';
    addressInputList[6][1].controller!.text = address.zip ?? '';
    addressInputList[7][0].controller!.text = address.phone ?? '';
    if (countryList.isNotEmpty) {
      var tempCountryList = countryList
          .where((element) => element.name == address.country)
          .toList();
      if (tempCountryList.isNotEmpty) {
        selectCountry = tempCountryList[0];
      } else {
        selectCountry = countryList[0];
      }
    }
    setCountryData();
    provincesList = selectCountry.provinces ?? [];
    if (provincesList.isNotEmpty) {
      var tempProvinceList = provincesList
          .where((element) => element.name == address.province)
          .toList();
      if (tempProvinceList.isNotEmpty) {
        selectProvince = tempProvinceList[0];
        addressInputList[6][0].controller!.text =
            getThumbnailString(selectProvince!.name!);
      } else {
        selectProvince = null;
        addressInputList[6][0].controller!.text = '';
      }

      addressInputList[6][0].show = true;
    } else {
      selectProvince = null;
      addressInputList[6][0].show = false;
    }
  }

  updateShippingAddressModel() {
    selectShippingAddress = AddressModel(
      country: selectCountry.name ?? '',
      countryCodeV2: selectCountry.code ?? '',
      province: selectProvince?.name ?? '',
      provinceCode: selectProvince?.code ?? '',
      firstName: addressInputList[0][0].controller!.text,
      lastName: addressInputList[1][0].controller!.text,
      address1: addressInputList[3][0].controller!.text,
      address2: addressInputList[4][0].controller!.text,
      city: addressInputList[5][0].controller!.text,
      phone: addressInputList[7][0].controller!.text,
      zip: addressInputList[6][1].controller!.text,
      name:
          '${addressInputList[0][0].controller!.text} ${addressInputList[1][0].controller!.text}',
      rememberAddress: rememberAddress,
    );
  }

  compareAddress(AddressModel addOne, AddressModel addTwo) {
    if (addOne.toEqualJson() == addTwo.toEqualJson()) {
      return true;
    } else {
      return false;
    }
  }

  setCountryData() {
    addressInputList[2][0].controller!.text = '       ${selectCountry.name!}';
    addressInputList[2][0].prefixIcon = Container(
      margin: const EdgeInsets.only(
        top: 17,
      ),
      child: ClipOval(
        child: AppCacheNetworkImage(
          imageUrl: getFlagUrl(selectCountry.code!),
          boxFit: BoxFit.fitHeight,
          width: 18,
          height: 18,
        ),
      ),
    );
  }

  String getFlagUrl(String countryCode) {
    var imageUrlPrefix =
        'https://d1mp1ehq6zpjr9.cloudfront.net/static/images/flags/';
    return '$imageUrlPrefix$countryCode.png';
  }

  getThumbnailString(String str) {
    if (str.length < 15) {
      return str;
    }
    var strList = str.split(' ');
    var tempStr = '';
    for (var s in strList) {
      if (s.isNotEmpty) {
        tempStr = tempStr + s[0].toUpperCase();
      }
    }
    return tempStr;
  }
}
