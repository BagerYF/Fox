import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/profile/help_and_contacts/help_and_contacts_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/custom_input_item.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class HelpAndContactsPage extends StatelessWidget {
  HelpAndContactsPage({Key? key}) : super(key: key);

  final HelpAndContactsPageController controller =
      Get.put(HelpAndContactsPageController());
  final bottomSafe = Get.context!.mediaQueryPadding.bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Help and Contacts",
      ),
      body: GetBuilder<HelpAndContactsPageController>(
        builder: (_) {
          return Form(
            key: controller.helpFormKey,
            onChanged: () {
              controller.update();
            },
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoScrollBehavior(),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                          ),
                          child: const Text(
                            'To submit an inquiry simply complete the contact form below and tap ‘Send’.  We aim to get back to you in one business day.',
                            style: AppTextStyle.Black16,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                          ),
                          child: const Text(
                            'For information relating to common questions and inquiries please see the links below:',
                            style: AppTextStyle.Black16,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 18,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Frequently Asked Questions',
                              style: AppTextStyle.Grey16_Underline_9E9E9E,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Orders and Shipping',
                              style: AppTextStyle.Grey16_Underline_9E9E9E,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Returns and Refunds',
                              style: AppTextStyle.Grey16_Underline_9E9E9E,
                            ),
                          ),
                        ),
                        Container(
                          height: 22,
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 32, bottom: 0),
                          child: const Text(
                            'Contact Form',
                            style: AppTextStyle.BlackBold16,
                          ),
                        ),
                        ...controller.helpInputListUp
                            .map((e) => CustomInputItem(
                                  inputItems: e,
                                ))
                            .toList(),
                        Container(
                          height: 22,
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 32,
                          ),
                          child: const Text(
                            'Is this Enquiry related to an existing order?*',
                            style: AppTextStyle.Black16,
                          ),
                        ),
                        Container(
                            height: 38,
                            margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    controller.showErrorMsg = false;
                                    controller.showOrder = 1;
                                    controller.update();
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: controller.showOrder == 1
                                              ? Image.asset(
                                                  LocalImages.asset('check_y'),
                                                )
                                              : Image.asset(
                                                  LocalImages.asset('check_n_'),
                                                ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: const Text(
                                            'Yes',
                                            style: AppTextStyle.Black16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.showErrorMsg = false;
                                    controller.showOrder = 2;
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: controller.showOrder == 2
                                              ? Image.asset(
                                                  LocalImages.asset('check_y'),
                                                )
                                              : Image.asset(
                                                  LocalImages.asset('check_n_'),
                                                ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: const Text(
                                            'No',
                                            style: AppTextStyle.Black16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        if (controller.showErrorMsg)
                          Container(
                            height: 22,
                            margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              // top: 16,
                            ),
                            child: const Text(
                              'Please choose one of the above options',
                              style: AppTextStyle.Red12_CB0000,
                            ),
                          ),
                        if (controller.showOrder == 1)
                          ...controller.helpInputList
                              .map((e) => CustomInputItem(
                                    inputItems: e,
                                  ))
                              .toList(),
                        ...controller.helpInputListDown
                            .map((e) => CustomInputItem(
                                  inputItems: e,
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                Offstage(
                  offstage: !controller.showTipMsg,
                  child: AnimatedOpacity(
                    opacity: controller.showTipMsg ? 1 : 0,
                    duration: const Duration(milliseconds: 350),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: AppColors.GREY_E0E0E0,
                      ),
                      child: const Text(
                        'Message Sent',
                        style: AppTextStyle.Black14,
                      ),
                    ),
                  ),
                ),
                if (!controller.showKeyboard)
                  BottomAnimationButton(
                    controller: controller.btnController,
                    margin: EdgeInsets.fromLTRB(
                        16, 16, 16, bottomSafe == 0 ? 24 : bottomSafe + 12),
                    text: controller.txt,
                    onTap: () {
                      controller.sendClick();
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
