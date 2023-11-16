import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/input/input_model.dart';
import 'package:fox/data/model/region/model/region_model.dart';
import 'package:fox/data/services/address/address_service.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/tools/postcode_validate/postcode_validate.dart';
import 'package:fox/utils/widget/network_image.dart';
import 'package:fox/utils/widget/rounded_loading_button.dart';

class SavedAddressDetailPageController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
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
  final addressFormKey = GlobalKey<FormState>();
  List<List<InputItemModel>> addressInputList = [];
  List<Country> countryList = [];
  List<Provinces> provincesList = [];
  Country? selectCountry;
  Provinces? selectProvince;
  bool isShippingDefault = false;
  bool showDefault = true;
  bool billingAddress = false;
  bool formProfile = false;
  AddressModel? tempAddress;
  bool isFirst = false;

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  late StreamSubscription<bool> keyboardSubscription;
  var showKeyboard = false;

  @override
  void onInit() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      showKeyboard = visible;
      update();
      Future.delayed(const Duration(milliseconds: 200))
          .whenComplete(() => update());
    });
    initData();
    super.onInit();
  }

  @override
  void dispose() {
    for (var items in addressInputList) {
      for (var i in items) {
        i.controller?.dispose();
      }
    }
    keyboardSubscription.cancel();
    super.dispose();
  }

  initData() {
    formProfile = Get.arguments['formProfile'] ?? false;
    countryList = Get.arguments['countryList'];
    isFirst = Get.arguments['isFirst'] ?? false;
    for (var item in countryList) {
      item.selected = false;
    }
    billingAddress = Get.arguments['billingAddress'] ?? false;
    tempAddress = Get.arguments['addressModel'];
    addressInputList = getInputItemModelList(addressInputTitleList);
    if (tempAddress == null) {
      RegionModel? defaultRegion = ProfilePageController.to.region;

      if (countryList.isNotEmpty) {
        var tempCountryList = countryList
            .where((element) => element.name == defaultRegion.name)
            .toList();
        if (tempCountryList.isNotEmpty) {
          selectCountry = tempCountryList[0];
        } else {
          selectCountry = countryList[0];
        }
      }
      addressInputList[2][0].controller!.text = '      ${selectCountry!.name!}';
      addressInputList[2][0].prefixIcon = Container(
        margin: const EdgeInsets.only(top: 17),
        child: ClipOval(
          child: AppCacheNetworkImage(
            imageUrl: getFlagUrl(selectCountry!.code!),
            boxFit: BoxFit.fitHeight,
            width: 18,
            height: 18,
          ),
        ),
      );
      provincesList = selectCountry!.provinces ?? [];
      if (provincesList.isNotEmpty) {
        selectProvince = null;
        addressInputList[6][0].controller!.text = '';
        addressInputList[6][0].show = true;
      } else {
        selectProvince = null;
        addressInputList[6][0].controller!.text = '';
        addressInputList[6][0].show = false;
      }
    } else {
      addressInputList[0][0].controller!.text = tempAddress!.firstName ?? '';
      addressInputList[1][0].controller!.text = tempAddress!.lastName ?? '';
      addressInputList[3][0].controller!.text = tempAddress!.address1 ?? '';
      addressInputList[4][0].controller!.text = tempAddress!.address2 ?? '';
      addressInputList[5][0].controller!.text = tempAddress!.city ?? '';
      addressInputList[6][1].controller!.text = tempAddress!.zip ?? '';
      addressInputList[7][0].controller!.text = tempAddress!.phone ?? '';
      isShippingDefault = tempAddress!.isShippingDefault;
      if (isShippingDefault) {
        showDefault = false;
      }

      if (countryList.isNotEmpty) {
        var tempCountryList = countryList
            .where((element) => element.name == tempAddress!.country)
            .toList();
        if (tempCountryList.isNotEmpty) {
          selectCountry = tempCountryList[0];
        } else {
          selectCountry = countryList[0];
        }
      }
      addressInputList[2][0].controller!.text = '      ${selectCountry!.name!}';
      addressInputList[2][0].prefixIcon = Container(
        margin: const EdgeInsets.only(top: 17),
        child: ClipOval(
          child: AppCacheNetworkImage(
            imageUrl: getFlagUrl(selectCountry!.code!),
            boxFit: BoxFit.fitHeight,
            width: 18,
            height: 18,
          ),
        ),
      );
      provincesList = selectCountry!.provinces ?? [];
      if (provincesList.isNotEmpty) {
        var tempProvinceList = provincesList
            .where((element) => element.name == tempAddress!.province)
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
    if (selectCountry != null && countryList.isNotEmpty) {
      for (var item in countryList) {
        if (selectCountry!.name == item.name) {
          item.selected = true;
        }
      }
    }
    if (selectProvince != null && provincesList.isNotEmpty) {
      for (var item in provincesList) {
        if (selectProvince!.name == item.name) {
          item.selected = true;
        }
      }
    }
    update();
  }

  selectCountries() async {
    var result = await Get.toNamed(AppRouters.checkoutCountryPage,
        arguments: countryList);

    if (result != null) {
      selectCountry = result as Country;
      for (var item in countryList) {
        if (item.code == selectCountry!.code) {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
      addressInputList[2][0].controller!.text = '      ${selectCountry!.name!}';
      addressInputList[2][0].prefixIcon = Container(
        margin: const EdgeInsets.only(top: 17),
        child: ClipOval(
          child: AppCacheNetworkImage(
            imageUrl: getFlagUrl(selectCountry!.code!),
            boxFit: BoxFit.fitHeight,
            width: 18,
            height: 18,
          ),
        ),
      );
      provincesList = selectCountry!.provinces ?? [];
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
    var result = await Get.toNamed(AppRouters.checkoutProvincePage,
        arguments: provincesList);
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

  getInputAddress() {
    return AddressModel(
      country: selectCountry?.name,
      countryCodeV2: selectCountry?.code,
      province: selectProvince?.name,
      provinceCode: selectProvince?.code,
      firstName: addressInputList[0][0].controller!.text,
      lastName: addressInputList[1][0].controller!.text,
      address1: addressInputList[3][0].controller!.text,
      address2: addressInputList[4][0].controller!.text,
      city: addressInputList[5][0].controller!.text,
      zip: addressInputList[6][1].controller!.text,
      phone: addressInputList[7][0].controller!.text,
      name:
          '${addressInputList[0][0].controller!.text} ${addressInputList[1][0].controller!.text}',
      isShippingDefault: isShippingDefault,
    );
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
          'titleTextStyle': AppTextStyle.Black12,
          'showTitle': true,
          if (i == 'Country') 'onTap': selectCountries,
          if (i == 'Country' || i == 'State')
            'suffixIcon': Container(
              margin: const EdgeInsets.only(top: 16, right: 5),
              child: Image.asset(
                LocalImages.asset('arrow_down'),
              ),
            ),
          if (i == 'State') 'onTap': selectProvinces,
          'key': GlobalKey(),
        });
        if (i == 'First Name') {
          addressItem.errorMsg = 'Enter a First name';

          addressItem.focusNode = focusNodes[0];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Last Name') {
          addressItem.errorMsg = 'Enter a Last name';

          addressItem.focusNode = focusNodes[1];
        }
        if (i == 'Address') {
          addressItem.errorMsg = 'Enter an address';
          addressItem.focusNode = focusNodes[2];
          addressItem.textInputAction = TextInputAction.next;
          addressItem.placeorderName = 'Street Address';
        }
        if (i == 'Apartment, Suite, Unit, Building') {
          addressItem.focusNode = focusNodes[3];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'City') {
          addressItem.errorMsg = 'Enter a city';
          addressItem.focusNode = focusNodes[4];
        }
        if (i == 'Postcode / Zipcode') {
          addressItem.errorMsg = 'Enter a ZIP / postal code';
          addressItem.placeorderName = 'Postcode';

          addressItem.focusNode = focusNodes[5];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Phone') {
          addressItem.placeorderName = 'Phone number';
          addressItem.focusNode = focusNodes[6];
        }

        tempList.add(addressItem);
      }
      tempAllList.add(tempList);
    }
    return tempAllList;
  }

  updateAddressClick() async {
    addressInputList[6][1].forceInvalidate = false;
    addressInputList[6][1].errorMsg = 'Enter a ZIP / postal code';
    update();
    var result = addressFormKey.currentState?.validate();

    if (result == false) {
      var resultValidate = await PostcodeValidate().checkPostCode(
          selectCountry?.code, addressInputList[6][1].controller?.text);
      if (resultValidate.length > 0) {
        addressInputList[6][1].forceInvalidate = true;
        addressInputList[6][1].errorMsg = resultValidate;
        addressFormKey.currentState?.validate();
        update();
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
          selectCountry?.code, addressInputList[6][1].controller?.text);
      if (resultValidate.length > 0) {
        addressInputList[6][1].forceInvalidate = true;
        addressInputList[6][1].errorMsg = resultValidate;
        addressFormKey.currentState?.validate();
        Scrollable.ensureVisible(addressInputList[6][1].key!.currentContext!);
        update();
        return;
      }

      if (tempAddress == null) {
        addAddress();
      } else {
        if (billingAddress) {
          Get.back(result: getInputAddress());
        } else {
          updateAddress();
        }
      }
    }
  }

  addAddress() async {
    btnController.start();

    var address = getInputAddress();

    await AddressService.customerAddressCreate(
      token: LoginController.to.token?.accessToken,
      address: address,
    );

    btnController.success();

    Timer(
      const Duration(seconds: 2),
      () {
        btnController.reset();
        Get.back(result: true);
      },
    );
  }

  updateAddress() async {
    btnController.start();

    var address = getInputAddress();

    await AddressService.updateAccountAddressBookEntry(
      token: LoginController.to.token?.accessToken,
      address: address,
      id: tempAddress!.id,
    );

    btnController.success();

    Timer(
      const Duration(seconds: 2),
      () {
        btnController.reset();
        Get.back(result: true);
      },
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
