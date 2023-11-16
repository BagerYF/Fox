// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../theme/styles/styles.dart';

class BackgroundGesture extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  const BackgroundGesture({Key? key, required this.child, this.onTap})
      : super(key: key);

  @override
  _BackgroundGestureState createState() => _BackgroundGestureState();
}

class _BackgroundGestureState extends State<BackgroundGesture> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (g) {
        print('onTapDown');
        setState(() {
          isClicked = true;
        });
      },
      onTapUp: (s) {
        print('onTapUp');
        Future.delayed(const Duration(milliseconds: 250), () {
          setState(() {
            isClicked = false;
          });
        });
      },
      onTapCancel: () {
        print('onTapCancel');
        Future.delayed(const Duration(milliseconds: 250), () {
          setState(() {
            isClicked = false;
          });
        });
      },
      child: Container(
        color: isClicked ? AppColors.GREY_F5F5F5 : Colors.white,
        child: widget.child,
      ),
    );
  }
}
