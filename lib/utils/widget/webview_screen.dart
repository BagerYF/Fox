import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  const WebViewScreen({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Text(widget.title, style: AppTextStyle.Black16),
      ),
      body: Stack(
        children: [
          if (show == false)
            Container(
              width: Get.width,
              height: Get.height,
              color: Colors.white,
              child: const SizedBox(),
            )
        ],
      ),
    );
  }
}
