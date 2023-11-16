import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/modules/profile/address/saved_address_page_controller.dart';
import 'package:fox/modules/profile/address/widget/address_item.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class SavedAddressPage extends GetView<SavedAddressPageController> {
  @override
  final SavedAddressPageController controller =
      Get.put(SavedAddressPageController());

  SavedAddressPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedAddressPageController>(
      builder: (_) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Address',
          ),
          body: bodyView(),
        );
      },
    );
  }

  bodyView() {
    Widget tempWidget;
    switch (controller.pageStatus) {
      case PageStatus.init:
        tempWidget = const Loading();
        break;
      case PageStatus.normal:
        tempWidget = SafeArea(
          child: ScrollConfiguration(
            behavior: NoScrollBehavior(),
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: false,
              enablePullUp: false,
              child: controller.haveDefaultAddress
                  ? ListView.builder(
                      itemCount: controller.addressList.length + 3,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return const SizedBox();
                        } else if (index == 1) {
                          return buildItem(0);
                        } else if (index == 2) {
                          return const SizedBox();
                        } else if (index == controller.addressList.length + 2) {
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 48,
                                bottom: 48,
                              ),
                              child: addButton(),
                            ),
                          );
                        } else {
                          return buildItem(index - 2);
                        }
                      },
                    )
                  : ListView.builder(
                      itemCount: controller.addressList.length + 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return const SizedBox();
                        } else if (index == controller.addressList.length + 1) {
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 48,
                                bottom: 48,
                              ),
                              child: addButton(),
                            ),
                          );
                        } else {
                          return buildItem(index - 1);
                        }
                      },
                    ),
            ),
          ),
        );
        break;
      case PageStatus.empty:
        tempWidget = Center(
          child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 253),
            child: Column(
              children: [
                const Text(
                  'You have no saved addresses',
                  style: AppTextStyle.Black16,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: addButton(),
                ),
              ],
            ),
          ),
        );
        break;
      default:
        tempWidget = const SizedBox();
    }
    return tempWidget;
  }

  addButton() {
    return BottomButton(
      text: 'Add Address',
      onTap: () {
        controller.getToDetail(-1);
      },
    );
  }

  Widget buildItem(int index) {
    AddressModel address = controller.addressList[index];
    var top = 10.0;
    if (index == 0 || index == 1) {
      top = 26;
    }
    return Container(
      padding: EdgeInsets.only(left: 16, top: top, right: 16, bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColors.GREY_E0E0E0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddressItem(
            address,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.getToDetail(index);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 16, 5),
                  child: Row(
                    children: [
                      Image.asset(LocalImages.asset('address_edit')),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        'Edit',
                        style: AppTextStyle.BlackBold14,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.removeAddress(index);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    children: [
                      Image.asset(LocalImages.asset('address_del')),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        'Delete',
                        style: AppTextStyle.BlackBold14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
