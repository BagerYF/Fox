import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/data/services/loading/loading_service.dart';
import 'package:fox/routes/routers.dart';

class NetworkService {
  checkNetwork({
    bool backable = true,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      LoadingService().dismiss();
      var result = await Get.toNamed(AppRouters.networkPage, arguments: {
        'backable': backable,
      });
      if (result == null) {
        throw ExceptionModel(
          type: ExceptionType.back,
        );
      }
    }
  }

  serverError({
    String message = '',
    bool backable = true,
  }) async {
    var result = await Get.toNamed(
      AppRouters.serverErrorPage,
      arguments: {
        'message': message,
        'backable': backable,
      },
    );
    if (result == null) {
    } else if (result == true) {
      throw ExceptionModel(
        type: ExceptionType.retry,
        message: message,
      );
    }
  }

  static Future<bool> checkSinglePageNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
