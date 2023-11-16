import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/designers/designers_list_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/list_item.dart';
import 'package:fox/utils/widget/loading.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class DesignersListPage extends StatelessWidget {
  const DesignersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Designers A–Z',
        actions: [CartPageController.to.cartView],
      ),
      body: SafeArea(
        bottom: false,
        child: GetBuilder<DesignersListPageController>(
          init: DesignersListPageController(),
          builder: (controller) => controller.initDone == false
              ? const Loading()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.WHITE_EEEEEE,
                                      width: 0.0),
                                  color: AppColors.WHITE_EEEEEE,
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Image.asset(
                                          LocalImages.asset('search')),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        onChanged: (value) {
                                          controller.search(value);
                                        },
                                        focusNode: focusNode,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: -9),
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                          hintStyle: AppTextStyle.Grey16_757575,
                                          constraints: BoxConstraints(
                                            maxHeight: 40,
                                          ),
                                        ),
                                        style: const TextStyle(fontSize: 16),
                                        controller:
                                            controller.textEditingController,
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.textEditingController
                                          .text.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            controller.textEditingController
                                                .clear();
                                            controller.search('');
                                          },
                                          child: Stack(
                                            children: [
                                              const SizedBox(
                                                width: 40,
                                                height: 40,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Center(
                                                  child: Image.asset(
                                                      LocalImages.asset(
                                                          'nav_close')),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.showKeyboard,
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('Cancel'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.originList.isNotEmpty
                        ? Expanded(
                            child: ScrollConfiguration(
                              behavior: NoScrollBehavior(),
                              child: AzListView(
                                data: controller.dataList,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: controller.dataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DesignerModel model =
                                      controller.dataList[index];
                                  return Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    child: ListItem(
                                        text: model.name ?? '',
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        onTap: () {
                                          Get.toNamed(AppRouters.productList,
                                              arguments: {'query': model.name});
                                        }),
                                  );
                                },
                                itemScrollController:
                                    controller.itemScrollController,
                                susItemBuilder:
                                    (BuildContext context, int index) {
                                  DesignerModel model =
                                      controller.dataList[index];
                                  return buildSusItem(
                                      context, model.getSuspensionTag());
                                },
                                indexBarWidth: 16,
                                indexBarItemHeight: 17.2,
                                indexBarOptions: const IndexBarOptions(
                                  textStyle: TextStyle(
                                    fontSize: 9,
                                    color: AppColors.BLACK,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        AppTextStyle.BASEL_GROTESK_MEDIUM,
                                  ),
                                  indexHintAlignment: Alignment.centerRight,
                                  indexHintTextStyle: TextStyle(
                                      fontSize: 24.0, color: AppColors.WHITE),
                                  indexHintOffset: Offset(-3000, 0),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildSusItem(BuildContext context, String tag,
      {double susHeight = 51}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16.0),
      color: AppColors.WHITE,
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: AppTextStyle.BlackBold16,
      ),
    );
  }
}
