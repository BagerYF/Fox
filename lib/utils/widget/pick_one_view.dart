// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/theme/styles/styles.dart';

class ItemModel {}

class PickOneView extends StatefulWidget {
  const PickOneView({
    Key? key,
    required this.title,
    required this.pickItems,
    this.callback,
    this.selectIndex,
    this.scrollable = true,
  }) : super(key: key);

  final String title;
  final List<String> pickItems;
  final selectIndex;
  final callback;
  final scrollable;

  @override
  _PickOneViewState createState() => _PickOneViewState();
}

class _PickOneViewState extends State<PickOneView> {
  List<PickItem> pickList = [];

  List<PickItem> getPickModalList() {
    List<PickItem> tempList = [];
    for (int i = 0; i < widget.pickItems.length; i++) {
      tempList.add(PickItem.fromJson({
        "name": widget.pickItems[i],
        "selected": widget.selectIndex == i ? true : false,
        "index": i
      }));
    }
    return tempList;
  }

  List<Widget> listView() {
    List<Widget> tempList = [];
    for (var item in pickList) {
      tempList.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: Get.width - 32,
          height: 40,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 16,
                height: 16,
                child: item.selected ?? false
                    ? Image.asset(LocalImages.asset('check_y'))
                    : Image.asset(
                        LocalImages.asset('check_n_'),
                      ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(item.name ?? '', style: AppTextStyle.Black16),
              )
            ],
          ),
        ),
        onTap: () {
          for (var items in pickList) {
            if (items.name == item.name) {
              items.selected = true;
            } else {
              items.selected = false;
            }
          }

          var result =
              pickList.where((element) => element.selected == true).toList();
          if (result.isNotEmpty) {
            widget.callback(result[0].index);
            Navigator.of(context).pop();
          }

          setState(() {});
        },
      ));
    }
    return tempList;
  }

  Widget titleView() {
    return SizedBox(
      width: Get.width,
      height: 64,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16),
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

  Widget selectView() {
    return Container(
        width: Get.width - 32,
        height: 40,
        margin: const EdgeInsets.fromLTRB(0, 32, 0, 32),
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
          child: const Text("Select"),
          onPressed: () {
            var result =
                pickList.where((element) => element.selected == true).toList();
            if (result.isNotEmpty) {
              widget.callback(result[0].index);
              Navigator.of(context).pop();
            }
          },
        ));
  }

  @override
  void initState() {
    super.initState();

    pickList = getPickModalList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 40.0 * pickList.length + 80,
      child: Column(
        children: <Widget>[
          titleView(),
          Expanded(
              child: widget.scrollable
                  ? ListView(
                      padding: const EdgeInsets.only(left: 16),
                      children: listView(),
                    )
                  : ListView(
                      padding: const EdgeInsets.only(left: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      children: listView(),
                    )),
          if (Get.bottomBarHeight == 0)
            const SizedBox(
              height: 16,
            )
          // selectView(),
        ],
      ),
    );
  }
}

class PickItem {
  String? name;
  bool? selected;
  int? index;

  PickItem({this.name, this.selected});

  PickItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    selected = json['selected'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['selected'] = selected;
    data['index'] = index;
    return data;
  }
}
