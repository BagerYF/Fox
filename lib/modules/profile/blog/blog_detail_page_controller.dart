import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetailPageController extends GetxController {
  var title = '';
  var url = '';
  var webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void onInit() {
    super.onInit();

    title = Get.arguments['title'];
    url = Get.arguments['url'];

    initData();
  }

  initData() async {
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

    webViewController.loadRequest(Uri.parse(url));
  }
}
