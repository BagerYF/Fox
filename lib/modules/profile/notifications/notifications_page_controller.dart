import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/modules/login/login_page_controller.dart';

class NotificationsPageController extends SuperController {
  var notifications = false;
  var subscription = false;
  bool isLogin = LoginController.to.isLogin;
  var initDone = false;
  var isLoading = false;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    try {
      var notificationStatus = await Permission.notification.status;
      if (notificationStatus == PermissionStatus.denied ||
          notificationStatus == PermissionStatus.permanentlyDenied) {
        notifications = false;
      } else {
        notifications = true;
      }
      initDone = true;
      update();
    } on ExceptionModel catch (e) {
      if (e.type == ExceptionType.back) {
        Get.back();
      } else if (e.type == ExceptionType.retry) {
        initData();
      }
      return;
    }
  }

  notificationsChange(bool isChecked) async {
    openAppSettings();
  }

  requestNotificationPermission() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      await Permission.notification.request();
    } else {
      if (notificationStatus == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  subscriptionChange(bool isChecked) async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    subscription = isChecked;
    update();
  }

  @override
  void onResumed() {
    initData();
  }

  @override
  void onDetached() {
    // implement onDetached
  }

  @override
  void onInactive() {
    // implement onInactive
  }

  @override
  void onPaused() {
    // implement onPaused
  }
}
