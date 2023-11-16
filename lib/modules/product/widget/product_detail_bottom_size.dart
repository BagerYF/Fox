// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/theme/styles/styles.dart';

class ProductDetailBottomSize extends StatefulWidget {
  const ProductDetailBottomSize({
    Key? key,
    required this.title,
    required this.pickItems,
    required this.callback,
    this.selectIndex,
  }) : super(key: key);

  final String title;
  final List<Variant>? pickItems;
  final selectIndex;
  final OnData<Map<String, dynamic>> callback;

  @override
  _ProductDetailBottomSizeState createState() =>
      _ProductDetailBottomSizeState();
}

class _ProductDetailBottomSizeState extends State<ProductDetailBottomSize> {
  int selectIndex = 0;
  bool isSoldOut = false;
  var bottomSafe = Get.context!.mediaQueryPadding.bottom;

  @override
  void initState() {
    super.initState();
    Variant variant = widget.pickItems![0];
    isSoldOut = variant.isSoldOut!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectIndexInit() {
    int length = widget.pickItems!.length;
    if (length > 2) {
      selectIndex = length ~/ 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppColors.WHITE,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitleView(),
          _buildCupertinoPickerView(),
          _buildSelectView(context),
        ],
      ),
    );
  }

  List<Widget> _getItems() {
    List<Widget> tempList = [];
    for (int i = 0; i < (widget.pickItems?.length ?? 0); i++) {
      Variant item = widget.pickItems![i];
      String leftItem = "";
      if (item.quantityAvailable == 0) {
        leftItem = 'Sold Out';
      } else if (item.quantityAvailable! == 1) {
        leftItem = 'Low Stock';
      }
      if (item.quantityAvailable! > 1 && item.quantityAvailable! < 6) {
        leftItem = '${item.quantityAvailable} Left';
      }
      tempList.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          // color: selectIndex == i ? AppColors.COLOR_EEEEEE : AppColors.WHITE,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.title ?? '',
                style: AppTextStyle.Black16,
              ),
              Text(
                leftItem,
                style: AppTextStyle.Grey14_9E9E9E,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        onTap: () {
          selectIndex = i;
          setState(() {});
        },
      ));
    }
    return tempList;
  }

  Widget _buildCupertinoPickerView() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1, color: AppColors.GREY_BDBDBD.withOpacity(.4)),
                    bottom: BorderSide(
                        width: 1,
                        color: AppColors.GREY_BDBDBD.withOpacity(.4)))),
          ),
        ),
        SizedBox(
            height: (40 * 5),
            child: CupertinoPicker(
              backgroundColor: Colors.transparent,
              itemExtent: 40,
              scrollController:
                  FixedExtentScrollController(initialItem: selectIndex),
              diameterRatio: 1.8,
              squeeze: 1,
              onSelectedItemChanged: (index) {
                selectIndex = index;

                Variant variant = widget.pickItems![index];
                if (isSoldOut != variant.isSoldOut!) {
                  setState(() {
                    isSoldOut = variant.isSoldOut!;
                  });
                }
              },
              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                  capStartEdge: false,
                  capEndEdge: false,
                  background: Colors.transparent),
              children: _getItems(),
            )),
      ],
    );
  }

  Widget _buildTitleView() {
    return SizedBox(
      width: Get.width,
      height: 64,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.title,
                style: AppTextStyle.Black14,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.clear,
                size: 16,
                color: AppColors.BLACK,
              ),
            )
          ]),
    );
  }

  Widget _buildSelectView(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        bottomSafe == 0 ? 24 : bottomSafe + 12,
      ),
      child: isSoldOut
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.GREY_9E9E9E,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      'Out of stock',
                      style: AppTextStyle.White16,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.WHITE),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          if (isSoldOut) {
                            return AppColors.GREY_BDBDBD;
                          } else {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.grey[600];
                            }
                            return AppColors.BLACK;
                          }
                        }),
                      ),
                      onPressed: () async {
                        if (!isSoldOut) {
                          Navigator.of(context).pop(selectIndex);
                          widget.callback.call({'index': selectIndex});
                        }
                      },
                      child: const Align(
                        child: Text(
                          'Select',
                          style: AppTextStyle.White16,
                        ),
                      ),
                      // style: _getButtonStyle(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class PickItem {
  String? name;
  String? sold;
  String? soldState;
  bool? selected;
  int? index;

  PickItem({this.name, this.selected, this.sold, this.soldState});

  PickItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sold = json['sold'];
    sold = json['sold'];
    selected = json['selected'];
    index = json['index'];
    soldState = json['soldState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['sold'] = sold;
    data['selected'] = selected;
    data['index'] = index;
    data['soldState'] = soldState;
    return data;
  }
}
