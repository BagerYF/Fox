// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';

class ShoppingCartSelectQuantity extends StatefulWidget {
  ShoppingCartSelectQuantity({
    Key? key,
    this.inventoryAvailableToSell,
    this.callback,
    this.selectIndex,
  }) : super(key: key);

  final selectIndex;
  final callback;
  final inventoryAvailableToSell;

  @override
  _ShoppingCartSelectQuanlityState createState() =>
      _ShoppingCartSelectQuanlityState();
}

class _ShoppingCartSelectQuanlityState
    extends State<ShoppingCartSelectQuantity> {
  late List<int>? pickItems;
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    int maxAmount = 1;
    if (widget.inventoryAvailableToSell <= 1) {
      maxAmount = 1;
    } else if (widget.inventoryAvailableToSell > 5) {
      maxAmount = 5;
    } else {
      maxAmount = widget.inventoryAvailableToSell;
    }
    if (widget.selectIndex <= maxAmount) {
      selectIndex = widget.selectIndex - 1;
    }
    pickItems = List.generate(maxAmount, (i) => i + 1);
    setState(() {});
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
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 200.0,
              maxHeight: 200.0,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: AppColors.GREY_BDBDBD.withOpacity(.4)),
                            bottom: BorderSide(
                                color: AppColors.GREY_BDBDBD.withOpacity(.4)))),
                  ),
                ),
                CupertinoPicker(
                  backgroundColor: Colors.transparent,
                  itemExtent: 40,
                  scrollController:
                      FixedExtentScrollController(initialItem: selectIndex),
                  diameterRatio: 1.8,
                  squeeze: 1,
                  onSelectedItemChanged: (index) {
                    selectIndex = index;
                  },
                  selectionOverlay:
                      const CupertinoPickerDefaultSelectionOverlay(
                          capStartEdge: false,
                          capEndEdge: false,
                          background: Colors.transparent),
                  children: _getItems(),
                ),
              ],
            ),
          ),
          _buildSelectView(),
        ],
      ),
    );
  }

  List<Widget> _getItems() {
    List<Widget> tempList = [];

    for (int i = 0; i < pickItems!.length; i++) {
      int item = pickItems![i];

      tempList.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: Text(
            '$item',
            style: AppTextStyle.Black16,
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

  Widget _buildTitleView() {
    return SizedBox(
      width: Get.width,
      height: 64,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Please select a quantity',
                style: AppTextStyle.Black14,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.clear, size: 16, color: AppColors.BLACK),
            )
          ]),
    );
  }

  Widget _buildSelectView() {
    var bottomSafe = Get.context!.mediaQueryPadding.bottom;
    return Container(
        width: Get.width,
        height: 40,
        margin: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          bottomSafe == 0 ? 24 : bottomSafe + 12,
        ),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0))),
            textStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 16, fontFamily: AppTextStyle.BASEL_GROTESK_MEDIUM)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor:
                MaterialStateProperty.resolveWith((states) => AppColors.WHITE),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.grey[600];
              }
              return AppColors.BLACK;
            }),
          ),
          child: const Text("Select"),
          onPressed: () {
            widget.callback?.call(pickItems![selectIndex]);
            Navigator.of(context).pop();
          },
        ));
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
