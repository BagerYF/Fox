import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/modules/chat/chat_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final ChatPageController controller = Get.find<ChatPageController>();
  var bottomSafe = Get.context!.mediaQueryPadding.bottom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatPageController>(
      init: controller,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: navView(),
            body: bodyView(),
          ),
        );
      },
    );
  }

  navView() {
    CustomAppBar tempWidget;
    switch (controller.pageStatus) {
      default:
        tempWidget = const CustomAppBar(
          title: 'Shopify',
        );
    }
    return tempWidget;
  }

  bodyView() {
    Widget tempWidget;
    switch (controller.pageStatus) {
      case PageStatus.init:
        tempWidget = const Loading();
        break;
      case PageStatus.webview:
        tempWidget = WebViewWidget(controller: controller.webViewController);
        break;
      case PageStatus.error:
        tempWidget = Container(
          alignment: Alignment.topCenter,
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Text(
                controller.errorMsg,
                textAlign: TextAlign.center,
                style: AppTextStyle.Black16,
              )),
        );
        break;
      default:
        tempWidget = const SizedBox();
    }
    return tempWidget;
  }
}
