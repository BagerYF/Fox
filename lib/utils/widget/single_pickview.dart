// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';

class SinglePickview extends StatefulWidget {
  const SinglePickview({
    Key? key,
    required this.pickItems,
    required this.callback,
    required this.selectIndex,
    required this.title,
    required this.selectText,
  }) : super(key: key);

  final selectIndex;
  final callback;
  final pickItems;
  final title;
  final selectText;

  @override
  _SinglePickviewState createState() => _SinglePickviewState();
}

class _SinglePickviewState extends State<SinglePickview> {
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    selectIndex = widget.selectIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppColors.WHITE,
      height: 344,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitleView(),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 200.0,
              maxHeight: 200.0, //Get,eight * 0.5,
            ),
            // child: SingleChildScrollView(
            //   child: Column(
            //     children: _getItems(),
            //   ),
            // ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
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
                  // diameterRatio: 1,
                  offAxisFraction: 0.1,
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
    // for (var i = 0; i < 5 - pickItems!.length; i++) {
    //   tempList.add(SizedBox(height: 40,));
    // }
    for (int i = 0; i < widget.pickItems!.length; i++) {
      var item = widget.pickItems![i];

      tempList.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          // color: selectIndex == i ? AppColors.COLOR_EEEEEE : AppColors.WHITE,
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
              child: Text(
                widget.title,
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
    return Container(
        width: Get.width,
        height: 40,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0))),
            textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 16,
              fontFamily: AppTextStyle.BASEL_GROTESK_MEDIUM,
            )),
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
          child: Text(widget.selectText),
          onPressed: () {
            widget.callback?.call(selectIndex);
            // _productDetailController.selectDetailSize(selectIndex);
            Navigator.of(context).pop();
          },
        ));
  }
}
