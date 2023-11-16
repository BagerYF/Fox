import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final String? title;
  final List<Widget>? actions;
  final bool? showCloseButton;
  final bool? back;
  final double elevation;
  final bool? home;

  const CustomAppBar({
    Key? key,
    this.titleWidget,
    this.actions = const [],
    this.showCloseButton = false,
    this.title,
    this.elevation = 0,
    this.back = true,
    this.home = false,
  }) : super(key: key);

  double navBarHeight() {
    return 44;
  }

  @override
  Size get preferredSize => Size.fromHeight(navBarHeight());

  Widget? _buildLeading(BuildContext context) {
    ModalRoute<Object?>? modalRoute = ModalRoute.of(context);
    if (!modalRoute!.canPop) {
      return null;
    }

    if (back == false) {
      return null;
    }

    return IconButton(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
      splashRadius: 20,
      splashColor: const Color(0x00EEEEEE),
      highlightColor: const Color(0x00EEEEEE),
      onPressed: () {
        Get.back();
      },
      icon: showCloseButton!
          ? Image.asset(LocalImages.asset('nav_close'))
          : Image.asset(LocalImages.asset('backarrow')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      height: 22 / 16,
      fontFamily: 'BaselGrotesk-medium',
    );
    return Column(
      children: [
        AppBar(
          titleTextStyle: titleStyle,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: titleWidget ??
                Text(
                  title ?? '',
                  style: titleStyle,
                ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          // shadowColor: const Color(0x00F5F5F5),
          titleSpacing: 0,
          toolbarHeight: 43,
          centerTitle: true,
          automaticallyImplyLeading: back!,
          leading: _buildLeading(context),
          actions: actions,
        ),
        Container(
          height: elevation,
          width: Get.width,
          color: const Color(0x00e0e0e0),
        ),
      ],
    );
  }
}
