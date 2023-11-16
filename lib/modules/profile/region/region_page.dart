import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/profile/region/region_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/network_image.dart';

class RegionPage extends StatelessWidget {
  RegionPage({Key? key}) : super(key: key);

  final RegionPageController controller = Get.put(RegionPageController());

  @override
  Widget build(BuildContext context) {
    var bottomSafe = Get.context!.mediaQueryPadding.bottom;
    return GetBuilder<RegionPageController>(
      builder: (_) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Region',
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Your selected region',
                          style: AppTextStyle.Black16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Region',
                          style: AppTextStyle.Black12,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          controller.selectRegion();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipOval(
                                  child: AppCacheNetworkImage(
                                    imageUrl: controller.regionImg,
                                    boxFit: BoxFit.fitHeight,
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.regionStr,
                                  maxLines: 1,
                                  style: AppTextStyle.Black16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 6),
                                child: Image.asset(
                                  LocalImages.asset('arrow_down'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: AppColors.GREY_9E9E9E,
                      ),
                    ],
                  ),
                ),
              ),
              BottomAnimationButton(
                controller: controller.btnController,
                text: controller.txt,
                margin: EdgeInsets.only(
                    bottom: bottomSafe == 0 ? 24 : bottomSafe + 12),
                onTap: () {
                  controller.selectRegion();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
