import 'package:flutter/material.dart';
import 'package:fox/theme/utils/persistent_bottom_nav_bar/persistent-tab-view.dart';

class ScreenArgument {
  String appBarTag;

  ScreenArgument(this.appBarTag);
}

void customPushNewScreen(
  BuildContext context, {
  required Widget screen,
  bool? withNavBar,
  bool fullscreenDialog = false,
}) {
  RouteSettings? settings;
  ScreenArgument? args;
  if (fullscreenDialog) {
    args = ScreenArgument('present');
  } else if (ModalRoute.of(context)!.settings.arguments != null) {
    args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
  }
  settings = args != null ? RouteSettings(arguments: args) : null;

  pushNewScreen(
    context,
    screen: Container(),
    withNavBar: withNavBar,
    customPageRoute: MaterialPageRoute(
      builder: (BuildContext context) {
        return screen;
      },
      fullscreenDialog: fullscreenDialog,
      settings: settings,
    ),
  );
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected,
      {required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        color: Colors.transparent, // for tap-able area of GestureDetector
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
                child: SizedBox(
                    width: 24,
                    height: 24,
                    child: isSelected ? item.inactiveIcon! : item.icon)),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                    child: Text(
                  item.title ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isSelected
                          ? (item.activeColorSecondary ??
                              item.activeColorPrimary)
                          : item.inactiveColorPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.0,
                      height: 20 / 11),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              int index = items.indexOf(item);
              return Flexible(
                child: _buildItem(item, selectedIndex == index, onTap: () {
                  onItemSelected(index);
                }),
              );
            }).toList(),
          ),
        ));
  }
}
