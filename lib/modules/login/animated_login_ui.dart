import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/modules/login/login_ui.dart';
import 'package:fox/utils/tools/eventbus/event_bus.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class AnimatedLoginUI extends StatefulWidget {
  final double marginBottom;

  const AnimatedLoginUI({Key? key, this.marginBottom = 0}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<AnimatedLoginUI>
    with TickerProviderStateMixin {
  late AnimationController _positionAnimationController;
  late Animation<double> _positionAnimation;
  late Tween<double> _positionTween;

  late AnimationController _fadeInAnimationController;
  late Animation<double> _fadeInAnimation;
  late Tween<double> _fadeInTween;

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _positionAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _positionTween = Tween(begin: 0.0, end: 0.0);
    _positionAnimation = _positionTween.animate(_positionAnimationController)
      ..addListener(() => setState(() {}));

    _fadeInAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _fadeInTween = Tween(begin: 0.0, end: 0.0);
    _fadeInAnimation = _fadeInTween.animate(_fadeInAnimationController)
      ..addListener(() => setState(() {}));

    bus.on("LoginUI", (index) {
      showFristLoginUI();
    });
  }

  @override
  void dispose() {
    super.dispose();
    bus.off('LoginUI');
  }

  showFristLoginUI() async {
    var isFrist = await LocalStorage().getStorage('showFristLoginUI');
    if (isFrist == null || !isFrist) {
      await LocalStorage().setBool('showFristLoginUI', true);
      Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
        Get.dialog(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            alignment: Alignment.center,
            child: LoginUI(
                home: true,
                onTapLogin: () {
                  LoginController.to.login();
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                },
                onTapRegister: () {
                  LoginController.to.login(isRegist: true);
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                },
                onDismissPressed: () {
                  Get.back();
                }),
          ),
          barrierColor: Colors.black.withOpacity(0.4),
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onDismissPressed() {}

  void _slideUpAnimation() {
    _setVisible(visible: false);
    _positionAnimationController.reset();
    _fadeInAnimationController.reset();
    _setVisible(visible: true);

    _positionTween.begin = 60.0;
    _positionTween.end = 0.0;

    _fadeInTween.begin = 0.0;
    _fadeInTween.end = 1.0;

    _positionAnimationController.forward();
    _fadeInAnimationController.forward();
  }

  void hideLoginUi() {
    _setVisible(visible: false);
  }

  void _setVisible({required bool visible}) {
    setState(() {
      _visible = visible;
    });
  }

  void showLoginUi({required bool withAnimation}) {
    if (withAnimation == true) {
      _slideUpAnimation();
    } else {
      _setVisible(visible: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: widget.marginBottom),
            child: SizedBox(
              height: 180,
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: ClipRect(
                  child: Transform.translate(
                      offset: Offset(0.0, _positionAnimation.value),
                      child: LoginUI(
                        onTapLogin: () {
                          LoginController.to.login();
                        },
                        onTapRegister: () {
                          LoginController.to.login(isRegist: true);
                        },
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
