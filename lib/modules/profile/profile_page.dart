import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/cart/cart_page_controller.dart';
import 'package:fox/modules/login/login_ui.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/background_gesture.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class ProfileListName {
  static const myOrder = "My Orders";
  static const faq = "FAQ";
  static const helpAndContacts = "Help and Contacts";
  static const about = "About";
  static const notifications = "Notifications";
  static const region = "Region";
  static const returnAndRefunds = "Return and Refunds";
  static const savedAddress = "Address";
  static const securityAndPassword = "Security and Password";
  static const blog = "Blog";
}

class Section {
  final List<String> listItems;
  final bool hideWhenLogout;
  final String listTitle;

  Section(
      {required this.listItems,
      required this.hideWhenLogout,
      this.listTitle = ""});
}

class ProfilePage extends StatelessWidget {
  final sectionList = [
    Section(
        listItems: [ProfileListName.myOrder, ProfileListName.savedAddress],
        hideWhenLogout: true),
    Section(
        listItems: [ProfileListName.region, ProfileListName.notifications],
        hideWhenLogout: false,
        listTitle: "Settings"),
    Section(listItems: [
      ProfileListName.about,
      ProfileListName.helpAndContacts,
      ProfileListName.faq,
      ProfileListName.returnAndRefunds,
      ProfileListName.blog
    ], hideWhenLogout: false, listTitle: "Support")
  ];

  final profileListMap = <String, String>{
    ProfileListName.about: AppRouters.profileAbout,
    ProfileListName.faq: AppRouters.profileFAQ,
    ProfileListName.helpAndContacts: AppRouters.profileHelpAndContacts,
    ProfileListName.myOrder: AppRouters.orderPage,
    ProfileListName.notifications: AppRouters.profileNotifications,
    ProfileListName.region: AppRouters.profileRegion,
    ProfileListName.returnAndRefunds: AppRouters.profileReturnAndRefunds,
    ProfileListName.savedAddress: AppRouters.savedAddressPage,
    ProfileListName.securityAndPassword: AppRouters.profileSecurityAndPassword,
    ProfileListName.blog: AppRouters.blogListPage
  };

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController controller = Get.find<ProfilePageController>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        actions: [CartPageController.to.cartView],
      ),
      body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GetBuilder<ProfilePageController>(
            builder: (_) {
              return ScrollConfiguration(
                behavior: NoScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.isLogin == true
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.only(bottom: 36),
                              child: LoginUI(
                                // home: true,
                                showDismiss: false,
                                onTapLogin: () {
                                  controller.login();
                                },
                                onTapRegister: () {
                                  controller.login(isRegist: true);
                                },
                              ),
                            ),
                      controller.isLogin
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                        'Welcome ${controller.displayName()}',
                                        style: AppTextStyle.Black16),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      controller.logout();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text('Sign Out',
                                          style: TextStyle(
                                              height: 19.6 / 14,
                                              fontSize: 14.0,
                                              color: AppColors.GREY_9E9E9E)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      _buildSections(context, controller.isLogin),
                      controller.isLogin
                          ? /*Padding(
                          padding: EdgeInsets.only(
                              top: 32.h, left: 136.w, right: 136.w, bottom: 48.h),
                          child: Container(
                            width: 93.w,
                            height: 32.h,
                            child: CustomButton(
                              text: "Sign out",
                              style: CustomButtonStyle.secondary,
                              onPressed: () {
                                controller.logout();
                              },
                            ),
                          ))*/
                          Center(
                              child: GestureDetector(
                                onTap: () {
                                  controller.logout();
                                },
                                child: Container(
                                  width: 93,
                                  height: 32,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      top: 32, bottom: 48),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    border: Border.all(
                                        color: AppColors.GREY_9E9E9E, width: 1),
                                  ),
                                  child: const Text('Sign out'),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(bottom: 8),
                            ),
                      GestureDetector(
                        onTap: () async {
                          Get.toNamed(AppRouters.termsAndConditions);
                        },
                        child: _buildListTitle(
                            topPadding: 0,
                            name: "Terms and Conditions",
                            fontSize: 14,
                            height: 20 / 14),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Get.toNamed(AppRouters.privacyPolicy);
                        },
                        child: _buildListTitle(
                            topPadding: 8,
                            name: "Privacy Policy",
                            fontSize: 14,
                            height: 20 / 14),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 8,
                            bottom: 90,
                          ),
                          child: Text(
                            "App Version ${ProfilePageController.to.appVersion}",
                            style: const TextStyle(
                                fontSize: 14,
                                height: 20 / 14,
                                color: AppColors.GREY_9E9E9E),
                          )),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildProfileListItem({
    required String name,
    required String routerName,
  }) {
    return BackgroundGesture(
      onTap: () async {
        Get.toNamed(routerName);
      },
      child: Container(
        height: 48,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: AppColors.GREY_EEEEEE))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            children: [
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, height: 1.375, color: AppColors.BLACK),
                ),
              )),
              Image.asset(LocalImages.asset('arrow')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTitle(
      {double leftPadding = 16,
      double bottomPadding = 0,
      double topPadding = 0,
      required String name,
      required double fontSize,
      required double height}) {
    return Padding(
        padding: EdgeInsets.only(
            left: leftPadding, bottom: bottomPadding, top: topPadding),
        child:
            Text(name, style: TextStyle(fontSize: fontSize, height: height)));
  }

  Widget _buildSection(
      {required List<String> listItems,
      String listTitle = "",
      required BuildContext context}) {
    List<Widget> list = [];
    if (listTitle != "") {
      list.add(_buildListTitle(
          bottomPadding: 8, fontSize: 14, height: 20 / 14, name: listTitle));
    }
    for (var item in listItems) {
      list.add(
          _buildProfileListItem(name: item, routerName: profileListMap[item]!));
    }
    return Padding(
      padding: EdgeInsets.only(bottom: _bottomHeight(listTitle)),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }

  double _bottomHeight(listTitle) {
    double height = 40;
    if (listTitle == 'Settings') {
      height = 20;
    }
    if (listTitle == 'Support') {
      height = 16;
    }
    return height;
  }

  Widget _buildSections(BuildContext context, bool isLogin) {
    List<Widget> displaySections = [];
    for (var section in sectionList) {
      if (isLogin == false && section.hideWhenLogout == false) {
        displaySections.add(_buildSection(
            listItems: section.listItems,
            listTitle: section.listTitle,
            context: context));
      } else if (isLogin == true) {
        displaySections.add(_buildSection(
            listItems: section.listItems,
            listTitle: section.listTitle,
            context: context));
      }
    }

    return Column(children: displaySections);
  }
}

//right--->left
class Right2LeftRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int durationMs;
  final Curve curve;

  Right2LeftRouter(
      {required this.child,
      this.durationMs = 300,
      this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (ctx, a1, a2) {
              return child;
            },
            transitionsBuilder: (
              ctx,
              a1,
              a2,
              Widget child,
            ) {
              return DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color(0xB2000000),
                ),
                child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(CurvedAnimation(parent: a1, curve: curve)),
                    child: child),
              );
            });
}
