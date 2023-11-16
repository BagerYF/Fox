import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/error/server_error_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';

class ServerErrorPage extends GetView<ServerErrorPageController> {
  @override
  final ServerErrorPageController controller =
      Get.put(ServerErrorPageController());

  ServerErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<ServerErrorPageController>(
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Server error',
              showCloseButton: true,
              back: Get.arguments['backable'] ?? true,
            ),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  _buildBody() {
    return Center(
      child: controller.show
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(width: 1.5, color: AppColors.BLACK),
                  ),
                  child: const Icon(
                    Icons.clear,
                    size: 26,
                    color: AppColors.BLACK,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 24),
                  width: Get.width - 60,
                  child: const Text(
                    'Server error',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.BlackBold16,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 8),
                  width: Get.width - 60,
                  child: Text(
                    controller.msg,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.Grey16_616161,
                  ),
                ),
                Container(
                  width: 108,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  margin: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () {
                      controller.retryClick();
                    },
                    child: const Text(
                      'Retry',
                      style: AppTextStyle.Black16,
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
