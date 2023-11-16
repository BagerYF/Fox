import 'package:flutter/material.dart';

typedef OnActionFinished = int Function(int index); // 进行数据清除工作，并返回当前list的length
typedef AnimateFinishedCallBack = void Function(int index);

// ignore: must_be_immutable
class AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;
  final AnimateFinishedCallBack onAnimateFinished;
  double dragStartPoint = 0.0;
  double draglength = 0.0;

  AnimatedListItem(this.index, this.child, this.onAnimateFinished, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListItemState();
  }
}

class ListItemState extends State<AnimatedListItem>
    with TickerProviderStateMixin {
  double triggerLength = 80.0;
  bool _slideEnd = false;
  bool _sizeEnd = false;

  Size? _size;

  late AnimationController _slideController;
  late AnimationController _sizeController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    initSlideAnimation();
    initSizeAnimation();
    WidgetsBinding.instance.addPostFrameCallback(onAfterRender);
  }

  @override
  void didUpdateWidget(AnimatedListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(onAfterRender);
  }

  void initSlideAnimation() {
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnimation = Tween(
            begin: const Offset(0.0, 0.0), end: const Offset(-1.0, 0.0))
        .animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
  }

  void initSizeAnimation() {
    _sizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _sizeAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _sizeController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _slideController.dispose();
    _sizeController.dispose();
  }

  void onAfterRender(Duration timeStamp) {
    _size = context.size;
  }

  @override
  Widget build(BuildContext context) {
    return buildItem();
  }

  Widget buildItem() {
    if (_slideEnd && _sizeEnd) {
      _slideController.value = 0.0;
      _sizeController.value = 0.0;
      _slideEnd = false;
      _sizeEnd = false;
    }
    return (_slideEnd
        ? SizeTransition(
            axis: Axis.vertical,
            sizeFactor: _sizeAnimation,
            child: Material(
              color: Colors.transparent,
              child: SizedBox.fromSize(size: _size),
            ),
          )
        : SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ));
  }

  double getSlideAnimatePhysicsValue(
      double oldValue, double newValue, double percent) {
    double addValue = (percent - oldValue) / percent * (newValue - oldValue);
    return (oldValue + addValue) * percent;
  }

  void slidToRemove() {
    _slideController.forward().whenComplete(() {
      setState(() {
        _slideEnd = true;
        _sizeController.forward().whenComplete(() {
          _sizeEnd = true;
          widget.onAnimateFinished(widget.index);
        });
      });
    });
  }
}
