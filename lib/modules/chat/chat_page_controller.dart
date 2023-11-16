import 'package:fox/config/config.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ChatPageController get to => Get.find<ChatPageController>();

  var webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  var errorMsg = 'We’re sorry, we do not...';

  var chatUrl = "${EnvironmentConfig.baseUrl}/pages/chat";

  PageStatus pageStatus = PageStatus.init;

  initData() async {
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

    webViewController.loadRequest(Uri.parse(chatUrl), headers: {
      'X-Shopify-Customer-Access-Token':
          LoginController.to.token?.accessToken ?? ''
    });
    pageStatus = PageStatus.webview;

    update();
  }
}
