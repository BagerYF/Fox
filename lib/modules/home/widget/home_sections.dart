import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

import '../home_page_controller.dart';

class HomeSectionName {
  static const doubleElevenSection = 'DoubleElevenSection';
  static const firstSection = 'FirstSection';
  static const primarySection = 'PrimarySection';
  static const newArrivalSection = 'NewArrivalSection';
  static const newSeasonSection = 'NewSeasonSection';
  static const popularSection = 'PopularSection';
  static const contemporarySection = 'ContemporarySection';
}

class HomeSectionSorting {
  final String name;
  final Axis direction;
  final bool showSectionTitle;
  final bool hideShopButton;
  final TextAlign pageTextAlign;

  HomeSectionSorting({
    required this.name,
    required this.direction,
    this.showSectionTitle = false,
    this.hideShopButton = false,
    this.pageTextAlign = TextAlign.left,
  });
}

final sectionNamesSorting = [
  HomeSectionSorting(
      name: HomeSectionName.doubleElevenSection, direction: Axis.vertical),
  HomeSectionSorting(
      name: HomeSectionName.firstSection, direction: Axis.horizontal),
  HomeSectionSorting(
      name: HomeSectionName.primarySection, direction: Axis.vertical),
  HomeSectionSorting(
    name: HomeSectionName.newArrivalSection,
    direction: Axis.horizontal,
    showSectionTitle: true,
    hideShopButton: true,
    pageTextAlign: TextAlign.center,
  ),
  HomeSectionSorting(
    name: HomeSectionName.newSeasonSection,
    direction: Axis.horizontal,
    showSectionTitle: true,
    hideShopButton: true,
    pageTextAlign: TextAlign.center,
  ),
  HomeSectionSorting(
      name: HomeSectionName.popularSection, direction: Axis.vertical),
  HomeSectionSorting(
    name: HomeSectionName.contemporarySection,
    direction: Axis.horizontal,
    showSectionTitle: true,
    hideShopButton: true,
    pageTextAlign: TextAlign.center,
  ),
];

// ignore: must_be_immutable
class HomeSections extends StatelessWidget {
  final HomepageController _controller = Get.find<HomepageController>();

  final List<SliverToBoxAdapter> sortedSections;

  HomeSections({
    Key? key,
    required this.sortedSections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sortedSections.isEmpty) {
      return Container();
    }

    return Container(
      color: AppColors.WHITE,
      child: ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: SmartRefresher(
          controller: _controller.refreshController,
          enablePullDown: false,
          enablePullUp: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox()),
              ...sortedSections,
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 20 + MediaQuery.of(context).padding.bottom + 40),
              )
            ],
          ),
        ),
      ),
    );
  }
}
