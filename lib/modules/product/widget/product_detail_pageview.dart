import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';
import 'package:fox/utils/widget/page_indicator.dart';

// ignore: constant_identifier_names
enum PageContentType { TopPage, BottomPage }

class ProductDetailPageView extends StatefulWidget {
  final List<Widget> widgetList;

  final PageContentType pageContent;

  const ProductDetailPageView(
      {super.key,
      required this.widgetList,
      this.pageContent = PageContentType.BottomPage});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailPageViewState createState() => _ProductDetailPageViewState();
}

class _ProductDetailPageViewState extends State<ProductDetailPageView> {
  int pageIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Function? onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
    return null;
  }

  Widget _topImages(context) {
    return SizedBox(
      width: Get.width - 32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SizedBox(
              height: 330,
              child: Transform.scale(
                scale: 1.121212,
                child: ScrollConfiguration(
                  behavior: NoScrollBehavior(),
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: onPageChanged,
                    children: widget.widgetList,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 54,
            child: Offstage(
              offstage: !(widget.widgetList.length > 1),
              child: PageIndicator(
                  numberOfPage: widget.widgetList.length,
                  pageIndex: pageIndex,
                  style: PageIndicatorStyle.wide),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomRecommended(context) {
    double viewportFraction = 1;
    List<Widget> children = [];

    for (int i = 0; i < widget.widgetList.length; i += 2) {
      children.add(_listWidget(
          widget.widgetList[i],
          i + 2 > widget.widgetList.length
              ? const SizedBox()
              : widget.widgetList[i + 1]));
    }
    return Container(
        height: (303 + 54),
        width: Get.width - 32,
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                height: 303,
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: ScrollConfiguration(
                    behavior: NoScrollBehavior(),
                    child: PageView(
                      controller: PageController(
                        viewportFraction: viewportFraction,
                      ),
                      scrollDirection: Axis.horizontal,
                      onPageChanged: onPageChanged,
                      children: children,
                    ),
                  ),
                ),
              ),
            ),
            Offstage(
              offstage: !(children.length > 1),
              child: PageIndicator(
                  numberOfPage: children.length,
                  pageIndex: pageIndex,
                  style: PageIndicatorStyle.wide),
            ),
          ],
        ));
  }

  Widget _listWidget(Widget widget, Widget nextWidget) {
    return Row(
      children: [
        widget,
        const SizedBox(
          width: 16,
        ),
        nextWidget
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageContentType.BottomPage == widget.pageContent
        ? _bottomRecommended(context)
        : _topImages(context);
  }
}
