import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/modules/main/main_page.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/refresh_loading_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const ClassicHeader(
        completeIcon: SizedBox(),
        completeDuration: Duration(milliseconds: 50),
        completeText: '',
        idleIcon: Icon(
          Icons.arrow_downward_rounded,
          color: Colors.grey,
        ),
        idleText: 'Pull down to refresh',
        refreshingText: '',
        refreshingIcon: RefreshLoading(
          width: 18,
          height: 18,
          color: AppColors.GREY_212121,
        ),
      ),
      footerBuilder: () => const ClassicFooter(
        loadingText: '',
        noDataText: '',
        spacing: 0,
        loadingIcon: RefreshLoading(
          width: 18,
          height: 18,
          color: AppColors.GREY_212121,
        ),
      ),
      headerTriggerDistance: 80.0,
      springDescription:
          const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      maxOverScrollExtent: 100,
      maxUnderScrollExtent: 0,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: true,
      enableBallisticLoad: true,
      child: GetMaterialApp(
        transitionDuration: const Duration(milliseconds: 250),
        defaultTransition: Transition.rightToLeft,
        popGesture: true,
        title: 'Flutter Demo',
        getPages: AppRouters.getPages,
        home: MainPage(),
        theme: ThemeData(
            fontFamily: AppTextStyle.BASEL_GROTESK,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            scaffoldBackgroundColor: AppColors.WHITE),
        builder: EasyLoading.init(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
