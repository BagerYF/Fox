import 'package:azlistview/azlistview.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/region/model/region_model.dart';
import 'package:fox/modules/profile/address/province/checkout_province_page_controller.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

const String kSuggestedTag = '★';

class ProvinceBean extends ISuspensionBean {
  static String imageUrlPrefix =
      'https://d1mp1ehq6zpjr9.cloudfront.net/static/images/flags/';

  Provinces provinces;
  bool? isDefault;

  ProvinceBean(this.provinces, {this.isDefault});

  @override
  String getSuspensionTag() {
    if (isDefault!) {
      return kSuggestedTag;
    }
    return getText()[0];
  }

  String getText() {
    return provinces.name ?? '';
  }

  bool getSelected() {
    return provinces.selected ?? false;
  }

  String get countryCode {
    return provinces.code ?? '';
  }

  String getFlagUrl() {
    return '$imageUrlPrefix$countryCode.png';
  }

  String getHeaderText() {
    if (isDefault!) {
      return 'Suggested';
    }
    return getSuspensionTag();
  }
}

class CheckoutProvincePage extends StatelessWidget {
  final CheckoutProvincePageController controller =
      Get.put(CheckoutProvincePageController());
  final _focusNode = FocusNode();

  CheckoutProvincePage({super.key});
  Widget _buildSectionHeader(ProvinceBean regionCurrencyBean) {
    double top = (regionCurrencyBean.isDefault ?? false) ? 15 : 15;
    return Padding(
        padding: EdgeInsets.only(
          top: top,
          left: 16,
          bottom: 14,
        ),
        child: Text(
          regionCurrencyBean.getHeaderText(),
          style: const TextStyle(
              fontSize: 16,
              height: 1,
              fontWeight: FontWeight.w500,
              fontFamily: AppTextStyle.BASEL_GROTESK_MEDIUM,
              color: AppColors.BLACK),
        ));
  }

  Widget _buildItem(BuildContext context, ProvinceBean provinceBean) {
    List<Widget> items = [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () {
            Provinces provinces = provinceBean.provinces;
            Get.back(result: provinces);
          },
          child: Container(
            height: 48,
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: AppColors.GREY_EEEEEE))),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              provinceBean.getText(),
                              style: const TextStyle(
                                  fontSize: 16, height: 22 / 16),
                              overflow: TextOverflow.ellipsis,
                            ))),
                    if (provinceBean.getSelected())
                      Image.asset(LocalImages.asset('selected'))
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ];

    if (provinceBean.isShowSuspension) {
      items.insert(0, _buildSectionHeader(provinceBean));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.WHITE_EEEEEE, width: 0.0),
                  color: AppColors.WHITE_EEEEEE,
                  borderRadius: BorderRadius.circular(4.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(LocalImages.asset('search')),
                    ),
                    Expanded(
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: controller.searchText,
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: -9),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: AppTextStyle.Grey16_757575,
                          constraints: BoxConstraints(maxHeight: 40),
                        ),
                        style: const TextStyle(fontSize: 16),
                        controller: controller.textEditingController,
                      ),
                    ),
                    Visibility(
                      visible: controller.searchPhrase.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: controller.clearSearchText,
                          child: Stack(
                            children: [
                              const SizedBox(
                                width: 40,
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Center(
                                  child: Image.asset(
                                      LocalImages.asset('nav_close')),
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
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: const Text(
                  'Cancel',
                  style: AppTextStyle.Black14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    RegionModel? defaultRegion = ProfilePageController.to.region;

    List<ProvinceBean> data = controller.provinceList
        .where((element) {
          if (controller.searchPhrase.isEmpty) {
            return true;
          }
          return element.name!
              .toLowerCase()
              .contains(controller.searchPhrase.toLowerCase());
        })
        .map((e) => ProvinceBean(e, isDefault: e.code == defaultRegion.code))
        .toList();

    data.sort((a, b) {
      if (a.getSuspensionTag() == kSuggestedTag) {
        return -1;
      } else if (b.getSuspensionTag() == kSuggestedTag) {
        return 1;
      }
      return a.getText().compareTo(b.getText());
    });

    SuspensionUtil.setShowSuspensionStatus(data);

    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          _buildSearchField(),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoScrollBehavior(),
              child: AzListView(
                data: data,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(context, data[index]);
                },
                indexBarData: const [...kIndexBarData],
                indexBarWidth: 16,
                indexBarItemHeight: 18.6,
                indexBarOptions: const IndexBarOptions(
                  textStyle: TextStyle(
                    fontSize: 9,
                    color: AppColors.BLACK,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTextStyle.BASEL_GROTESK_MEDIUM,
                  ),
                  indexHintAlignment: Alignment.centerRight,
                  indexHintTextStyle:
                      TextStyle(fontSize: 24.0, color: AppColors.WHITE),
                  indexHintOffset: Offset(-3000, 0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: 'Select your region'),
        body: GetBuilder<CheckoutProvincePageController>(
          init: controller,
          builder: (_) {
            return _buildBody(context);
          },
        ),
      ),
    );
  }
}
