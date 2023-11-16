import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/Customer/Customer_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/input/input_model.dart';
import 'package:fox/data/model/token/token_model.dart';
import 'package:fox/data/services/login/login_service.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  bool isLogin = false;
  bool isRegister = false;
  bool emailSubscribe = true;
  TokenModel? token;
  CustomerModel? customer;

  var infoInputTitleList = [
    ['First Name', 'Last Name'],
    ['Email'],
    ['Password'],
  ];
  final infoFormKey = GlobalKey<FormState>();
  List<List<InputItemModel>> infoInputList = [];

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  initData() async {
    var tokenLocal =
        await LocalStorage().getStorage(AppString.LOCALSTORAGE_TOKEN);
    if (tokenLocal != null) {
      token = TokenModel.fromJson(tokenLocal);
      var customerLocal =
          await LocalStorage().getStorage(AppString.LOCALSTORAGE_Customer);
      if (customerLocal != null) {
        customer = CustomerModel.fromLocalJson(customerLocal);
        ProfilePageController.to.isLogin = true;
        ProfilePageController.to.update();
      }
      queryCustomer();
    }
  }

  login({bool isRegist = false}) async {
    infoInputList = getInputItemModelList(infoInputTitleList);
    isRegister = isRegist;
    update();
  }

  logout() async {
    Get.until((route) => Get.currentRoute == AppRouters.main);
    LocalStorage().removeStorage(AppString.LOCALSTORAGE_TOKEN);
    LocalStorage().removeStorage(AppString.LOCALSTORAGE_Customer);
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
          'titleTextStyle': AppTextStyle.Black12,
          'showTitle': true,
          'key': GlobalKey(),
          'isEmpty': false,
          'optional': false,
        });
        if (i == 'First Name') {
          addressItem.errorMsg = 'Enter a First name';
          addressItem.focusNode = focusNodes[0];
        }
        if (i == 'Last Name') {
          addressItem.errorMsg = 'Enter a Last name';
          addressItem.focusNode = focusNodes[1];
          // addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Email') {
          addressItem.errorMsg = 'Enter an address';
          addressItem.focusNode = focusNodes[2];
        }
        if (i == 'Password') {
          addressItem.errorMsg = 'Enter a password';
          addressItem.focusNode = focusNodes[3];
        }

        tempList.add(addressItem);
      }
      tempAllList.add(tempList);
    }
    return tempAllList;
  }

  loginClick() async {
    // var result = infoFormKey.currentState?.validate();
    token = await LoginService().customerAccessTokenCreate({
      'email': 'bager1@163.com',
      'password': '123321',
    });
    LocalStorage().setObject(AppString.LOCALSTORAGE_TOKEN, token!.toJson());
    await queryCustomer(loadingType: LoadingType.display);
    Get.back(result: true);
  }

  registerClick() async {
    await LoginService().customerCreate({
      'email': 'bager1@163.com',
      'password': '123321',
      'firstName': 'Bager',
      'lastName': 'Zhang',
      'acceptsMarketing': true,
    });
    isRegister = false;
    update();
  }

  queryCustomer({
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    customer = await LoginService().queryCustomer(
      {
        'customerAccessToken': token?.accessToken,
      },
      loadingType: loadingType,
    );
    LocalStorage()
        .setObject(AppString.LOCALSTORAGE_Customer, customer!.toJson());
    ProfilePageController.to.isLogin = true;
    ProfilePageController.to.update();
  }

  @override
  void dispose() {
    for (var items in infoInputList) {
      for (var i in items) {
        i.controller?.dispose();
      }
    }
    super.dispose();
  }
}
