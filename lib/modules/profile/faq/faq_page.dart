import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/profile/faq/faq_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class Faq extends StatelessWidget {
  Faq({Key? key}) : super(key: key);

  final FaqPageController controller = Get.put(FaqPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "FAQ",
        ),
        body: GetBuilder<FaqPageController>(
          builder: (_) {
            return SafeArea(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ScrollConfiguration(
                  behavior: NoScrollBehavior(),
                  child: ListView.builder(
                    itemCount: controller.infoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: AppColors.GREY_F5F5F5),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                for (var item in controller.infoList) {
                                  if (item['title'] ==
                                      controller.infoList[index]['title']) {
                                    item['fold'] = !item['fold'];
                                  } else {
                                    item['fold'] = false;
                                  }
                                }
                                controller.update();
                              },
                              child: Container(
                                height: 47,
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Text(
                                          controller.infoList[index]['title'],
                                          style: AppTextStyle.Black16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: controller.infoList[index]
                                                  ['fold'] ==
                                              true
                                          ? Image.asset(
                                              LocalImages.asset('arrow_up'),
                                            )
                                          : Image.asset(
                                              LocalImages.asset('arrow_down'),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (controller.infoList[index]['fold'] == true)
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16, top: 17, bottom: 32, right: 16),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  controller.infoList[index]['text'],
                                  style: AppTextStyle.Grey16_616161,
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ));
  }
}
