import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';

class LoginUI extends StatefulWidget {
  final Function? onDismissPressed;
  final Function onTapLogin;
  final Function onTapRegister;
  final bool? home;
  const LoginUI({
    Key? key,
    this.onDismissPressed,
    this.showDismiss = true,
    required this.onTapLogin,
    required this.onTapRegister,
    this.home = false,
  }) : super(key: key);
  final bool showDismiss;

  @override
  // ignore: library_private_types_in_public_api
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.WHITE,
      decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(widget.home! ? 4.0 : 0)),
      child: Wrap(alignment: WrapAlignment.center, children: [
        Padding(
            padding: EdgeInsets.only(top: widget.home! ? 20 : 24, bottom: 24),
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: AppTextStyle.BlackBold16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.home!
                      ? "Login to view your orders and \n fast-track checkout"
                      : "Login to manage your orders and \n fast-track checkout",
                  style: const TextStyle(
                      fontSize: 16,
                      height: 22.4 / 16,
                      color: AppColors.GREY_212121),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                widget.onTapLogin();
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 8.0, left: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.BLACK,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: AppTextStyle.WhiteBold14,
                  )),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                widget.onTapRegister();
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.BLACK),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "Register",
                    style: AppTextStyle.BlackBold14,
                  )),
            )),
          ],
        ),
        widget.showDismiss
            ? Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: GestureDetector(
                  onTap: () {
                    if (widget.onDismissPressed != null) {
                      widget.onDismissPressed!();
                    }
                    //todo: dismiss
                  },
                  child: const Text(
                    "Dismiss",
                    style: TextStyle(fontSize: 12, height: 1.25),
                    textAlign: TextAlign.center,
                  ),
                ))
            : const SizedBox(
                height: 20,
              ),
      ]),
    );
  }
}
