import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/profile/blog/blog_detail_page_controller.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetailPage extends GetView<BlogDetailPageController> {
  @override
  final BlogDetailPageController controller =
      Get.put(BlogDetailPageController());

  BlogDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlogDetailPageController>(
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: controller.title,
          ),
          body: WebViewWidget(controller: controller.webViewController),
        );
      },
    );
  }
}
