import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:fox/modules/profile/notifications/notifications_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/loading.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key? key}) : super(key: key);

  final NotificationsPageController controller =
      Get.put(NotificationsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Notifications",
      ),
      body: GetBuilder<NotificationsPageController>(
        builder: (_) {
          return controller.initDone == false
              ? const Loading()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Container(
                        height: 44,
                        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: const Text(
                          'Receive push notifications from us to get latest offers and promotion.',
                          style: TextStyle(
                            color: AppColors.BLACK,
                            fontSize: 16,
                            height: 22 / 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Expanded(
                            child: Text(
                              'Push Notifications',
                              style: AppTextStyle.Black16,
                            ),
                          ),
                          CupertinoSwitch(
                            value: controller.notifications,
                            onChanged: (isChecked) {
                              controller.notificationsChange(isChecked);
                            },
                            activeColor: AppColors.BLACK,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: AppColors.GREY_EEEEEE,
                    ),
                    if (controller.isLogin)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Expanded(
                              child: Text(
                                'Email Notifications',
                                style: AppTextStyle.Black16,
                              ),
                            ),
                            CupertinoSwitch(
                              value: controller.subscription,
                              onChanged: (isChecked) {
                                controller.subscriptionChange(isChecked);
                              },
                              activeColor: AppColors.BLACK,
                            ),
                          ],
                        ),
                      ),
                    if (controller.isLogin)
                      const Divider(height: 1, color: AppColors.GREY_EEEEEE),
                  ],
                );
        },
      ),
    );
  }
}
