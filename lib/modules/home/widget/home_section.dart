import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/home/model/home_model.dart';
import 'package:fox/modules/home/home_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/bottom_button.dart';
import 'package:fox/utils/widget/network_image.dart';
import 'package:fox/utils/widget/page_indicator.dart';
import 'package:fox/utils/widget/size_provider.dart';
import 'home_sections.dart';

// ignore: constant_identifier_names
enum PageContentType { TwoPage, OtherPage }

class HomeSection extends StatefulWidget {
  final CmsSectionNode section;
  final Axis direction;
  final bool showSectionTitle;
  final bool hideShopButton;
  final TextAlign pageTextAlign;
  final PageContentType pageContent;

  const HomeSection(
      {super.key,
      required this.section,
      this.direction = Axis.vertical,
      this.showSectionTitle = false,
      this.hideShopButton = false,
      this.pageTextAlign = TextAlign.left,
      this.pageContent = PageContentType.TwoPage});

  @override
  // ignore: library_private_types_in_public_api
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  double imageMarginLeft = 16;
  int pageIndex = 0;
  List<double> _itemHeights = [];

  double get maxItemHeight {
    double height = 0;
    for (var element in _itemHeights) {
      if (element > height) {
        height = element;
      }
    }
    return height;
  }

  double screenWidth = Get.width;
  double imageWidth = 305;
  double pageWidth = 0.0;
  double viewportFraction = 0.0;
  double imageHeight = 374;

  List<Widget> pages = [];
  final _controller = ScrollController();
  ScrollPhysics? _physics;
  var allItems = [];

  @override
  void initState() {
    super.initState();

    pageWidth = imageWidth + imageMarginLeft;
    viewportFraction = pageWidth / screenWidth;

    _controller.addListener(() {
      var page = (_controller.offset / pageWidth).round();
      onPageChanged(page.toInt());
      if (_controller.position.haveDimensions && _physics == null) {
        setState(() {
          _physics = CustomScrollPhysics(itemDimension: pageWidth);
        });
      }
    });

    _itemHeights = widget.section.items!.map((e) => 0.0).toList();
  }

  void initItems() {
    if (pageIndex > widget.section.items!.length - 1) {
      pageIndex = widget.section.items!.isNotEmpty
          ? widget.section.items!.length - 1
          : 0;
    }
    pages = [];
    allItems = widget.section.items!.toList();
    allItems.asMap().forEach((index, element) {
      pages.add(_buildPage(element, index: index, imageHeight: imageHeight));
    });
  }

  onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget _buildPageImage(
      {required String imageUrl, required double imageHeight}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppCacheNetworkImage(
        type: CacheImageType.logo,
        imageUrl: imageUrl,
        boxFit: BoxFit.fill,
        height: imageHeight,
      ),
    );
  }

  Widget _buildPageText({required String text}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          text,
          textAlign: widget.pageTextAlign,
          style: const TextStyle(fontSize: 16, height: 1.375),
        ));
  }

  Widget _buildPageShopButton(VoidCallback? onShopNowPressed) {
    if (widget.hideShopButton) {
      return Container();
    }

    return SizedBox(
      width: double.infinity,
      height: 20,
      child: GestureDetector(
        onTap: () {
          onShopNowPressed!();
        },
        child: const SizedBox(
          height: 20,
          child: Text(
            'Shop Now',
            style: TextStyle(
              color: AppColors.GREY_9E9E9E,
              fontSize: 14.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(
    CmsSectionItemResponse item, {
    required int index,
    required double imageHeight,
  }) {
    if (item.absoluteImageUrl == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        HomepageController.to.goToProductListPage();
      },
      child: Container(
          width: pageWidth,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              right: index == allItems.length - 1 ? Get.width - pageWidth : 0),
          padding: EdgeInsets.only(left: imageMarginLeft),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizeProviderWidget(
                  onChildSize: (Size size) {
                    setState(() {
                      if (index < _itemHeights.length) {
                        _itemHeights[index] = size.height;
                      } else {
                        _itemHeights.add(size.height);
                      }
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPageImage(
                          imageUrl: item.absoluteImageUrl!,
                          imageHeight: imageHeight),
                      _buildPageText(text: item.text ?? ''),
                      _buildPageShopButton(() {
                        HomepageController homepageController =
                            Get.find<HomepageController>();
                        homepageController.goToProductListPage();
                      }),
                    ],
                  )),
            ],
          )),
    );
  }

  Widget _horizontalSection(context) {
    initItems();
    return Container(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
              ),
              child: SizedBox(
                width: screenWidth,
                height: maxItemHeight,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  physics: _physics,
                  cacheExtent: pages.length * pageWidth,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
            ),
            PageIndicator(
                numberOfPage: widget.section.items!.length,
                pageIndex: pageIndex,
                style: PageIndicatorStyle.home),
            if (widget.section.name == HomeSectionName.newSeasonSection ||
                widget.section.name == HomeSectionName.contemporarySection)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: BottomButton(
                  text: "Shop Now",
                  onTap: () {
                    HomepageController controller =
                        Get.find<HomepageController>();
                    controller.goToProductListPage();
                  },
                ),
              ),
          ],
        ));
  }

  Widget _verticalSections() {
    if (widget.section.name == HomeSectionName.doubleElevenSection) {
      return _doubleElevenSection();
    }
    List<Widget> children = [];
    for (var element in widget.section.items!) {
      children.add(
        GestureDetector(
          onTap: () {
            HomepageController homepageController =
                Get.find<HomepageController>();
            homepageController.goToProductListPage();
          },
          child: Padding(
              padding: EdgeInsets.only(
                  bottom: widget.section.items!.last == element ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AspectRatio(
                      aspectRatio: 343 / 274,
                      child: AppCacheNetworkImage(
                        type: CacheImageType.logo,
                        imageUrl: element.absoluteImageUrl,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        element.brand ?? '',
                        style: const TextStyle(
                            fontSize: 24,
                            height: 1.1,
                            fontFamily: 'TimesNow',
                            color: AppColors.BLACK),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        element.productName ?? '',
                        style: const TextStyle(fontSize: 16, height: 1.375),
                      )),
                  _buildPageShopButton(() {
                    HomepageController homepageController =
                        Get.find<HomepageController>();
                    homepageController.goToProductListPage();
                  }),
                ],
              )),
        ),
      );
    }

    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
        child: Column(
          children: children,
        ));
  }

  Widget _doubleElevenSection() {
    var element = widget.section.items!.first;
    var title = _removeTag(widget.section.title);
    title = title.replaceAll("%%", "\n");
    title = title.replaceAll("%%", " ").trim();
    return GestureDetector(
      onTap: () {
        HomepageController homepageController = Get.find<HomepageController>();
        homepageController.goToProductListPage();
      },
      child: Padding(
          padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                constraints: BoxConstraints(
                  minHeight: Get.width - 32,
                ),
                child: AppCacheNetworkImage(
                  type: CacheImageType.logo,
                  imageUrl: element.absoluteImageUrl,
                  boxFit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 32,
                      height: 38.4 / 32,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppTextStyle.BASEL_GROTESK,
                      color: AppColors.GREY_212121),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Text(
                    widget.section.subTitle ?? '',
                    style: AppTextStyle.Black14,
                  )),
              SizedBox(
                  width: Get.width,
                  height: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0))),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 16,
                          fontFamily: AppTextStyle.BASEL_GROTESK_MEDIUM)),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => AppColors.WHITE),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey[600];
                        }
                        return AppColors.BLACK;
                      }),
                    ),
                    child: const Text("Shop now"),
                    onPressed: () {
                      HomepageController homepageController =
                          Get.find<HomepageController>();
                      homepageController.goToProductListPage();
                    },
                  ))
            ],
          )),
    );
  }

  String _removeTag(String? htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText?.replaceAll(exp, '\n') ?? '';
  }

  Widget _buildSectionTitle() {
    if (!widget.showSectionTitle) {
      return Container();
    }

    return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 40,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _removeTag(widget.section.title),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24, height: 1, fontFamily: 'TimesNow'),
              ),
            ),
            Text(
              _removeTag(widget.section.subTitle),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, height: 1.375),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle(),
        widget.direction == Axis.horizontal
            ? _horizontalSection(context)
            : _verticalSections(),
      ],
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;
  const CustomScrollPhysics(
      {required this.itemDimension, ScrollPhysics? parent})
      : super(parent: parent);
  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    // ignore: deprecated_member_use
    final Tolerance tolerance = this.tolerance;
    final double target =
        _getTargetPixels(position as ScrollPosition, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
