// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/designers/designers_page.dart';
import 'package:fox/modules/home/home_page.dart';
import 'package:fox/modules/main/main_page_controller.dart';
import 'package:fox/modules/profile/profile_page.dart';
import 'package:fox/modules/search/search_page.dart';
import 'package:fox/modules/wishlist/wishlist_page.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/theme/utils/persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fox/utils/widget/custom_tabbar.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final MainPageController controller = Get.put(MainPageController());
  final PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens(BuildContext context) {
    return [
      HomePage(),
      const DesignersPage(),
      SearchPage(),
      WishlistPage(),
      ProfilePage(),
    ];
  }

  PersistentBottomNavBarItem _buildNavBarsItem(
      String title, String iconName, String iconNameSelect) {
    return PersistentBottomNavBarItem(
        icon: Image.asset(iconName),
        inactiveIcon: Image.asset(iconNameSelect),
        title: title,
        activeColorPrimary: AppColors.BLACK,
        inactiveColorPrimary: AppColors.GREY_BDBDBD);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _buildNavBarsItem("Home", LocalImages.asset('tab_home'),
          LocalImages.asset('tab_home_s')),
      _buildNavBarsItem("Designers", LocalImages.asset('tab_designers'),
          LocalImages.asset('tab_designers_s')),
      _buildNavBarsItem("Search", LocalImages.asset('tab_search'),
          LocalImages.asset('tab_search_s')),
      _buildNavBarsItem("Wishlist", LocalImages.asset('tab_wishlist'),
          LocalImages.asset('tab_wishlist_s')),
      _buildNavBarsItem("Profile", LocalImages.asset('tab_profile'),
          LocalImages.asset('tab_profile_s'))
    ];
  }

  @override
  Widget build(BuildContext context) {
    double navBarHeight = 50 + MediaQuery.of(context).padding.bottom;

    return GetBuilder<MainPageController>(
      builder: (_) {
        return WillPopScope(
          child: Scaffold(
            body: Stack(
              children: [
                PersistentTabView.custom(
                  context,
                  controller: tabController,
                  itemCount: _navBarsItems().length,
                  // This is required in case of custom style! Pass the number of items for the nav bar.
                  screens: _buildScreens(context),
                  confineInSafeArea: false,
                  handleAndroidBackButtonPress: true,
                  navBarHeight: navBarHeight,
                  resizeToAvoidBottomInset: true,
                  hideNavigationBarWhenKeyboardShows: true,
                  hideNavigationBar: false,
                  customWidget: CustomNavBarWidget(
                    items: _navBarsItems(),
                    selectedIndex: tabController.index,
                    onItemSelected: (int index) {
                      tabController.index = index;
                      controller.update();
                    },
                  ),
                ),
              ],
            ),
          ),
          onWillPop: () {
            return Future.value(false);
          },
        );
      },
    );
  }
}
