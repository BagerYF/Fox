import 'package:flutter/material.dart';
import 'package:fox/data/model/input/input_model.dart';
import 'package:fox/theme/styles/styles.dart';

class CustomInputItem extends StatelessWidget {
  final List<InputItemModel> inputItems;
  const CustomInputItem({Key? key, required this.inputItems}) : super(key: key);

  invalidEmail(String? input) {
    if (input == null || input.isEmpty) return false;
    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    return RegExp(regexEmail).hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    var inputItemsShow =
        inputItems.where((element) => element.show == true).toList();

    return LayoutBuilder(builder: (context, constrains) {
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SizedBox(
          width: constrains.maxWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: inputItemsShow
                .map(
                  (e) => Expanded(
                    child: Container(
                      // color: Colors.green,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (e.showTitle == true)
                                Container(
                                  height: 17,
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 24),
                                  child: Row(
                                    children: [
                                      Text(
                                        e.name ?? '',
                                        style: e.titleTextStyle ??
                                            AppTextStyle.Black12,
                                      ),
                                      if (e.optional == false)
                                        Text(
                                          '*',
                                          style: e.titleTextStyle ??
                                              AppTextStyle.Black12,
                                        ),
                                    ],
                                  ),
                                ),
                              if (e.optional == true)
                                Container(
                                    height: 17,
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(top: 24),
                                    child: const Text(
                                      'optional',
                                      style: AppTextStyle.Black12,
                                    )),
                            ],
                          ),
                          GestureDetector(
                            onTap: e.onTap,
                            behavior: HitTestBehavior.opaque,
                            child: Stack(
                              children: [
                                TextFormField(
                                  key: e.key,
                                  textInputAction: e.textInputAction,
                                  textCapitalization: (e.invalidEmail == true ||
                                          e.name == 'Postcode / Zipcode')
                                      ? TextCapitalization.none
                                      : TextCapitalization.sentences,
                                  obscureText: e.obscure ?? false,
                                  obscuringCharacter: '●',
                                  onChanged: e.onChange ?? (text) {},
                                  onFieldSubmitted: e.onSubmit,
                                  // enabled: e.onTap != null ? false : true,
                                  readOnly: e.onTap == null ? false : true,
                                  controller: e.controller,
                                  maxLines: e.lines,
                                  minLines: 1,
                                  enableInteractiveSelection: true,
                                  autofocus: e.autoFocus ?? false,
                                  maxLength: e.maxLength ?? 10000,
                                  buildCounter: (context,
                                          {currentLength = 0,
                                          maxLength = 0,
                                          isFocused = true}) =>
                                      null,
                                  cursorColor: AppColors.BLACK,
                                  style: AppTextStyle.Black16,
                                  validator: (string) {
                                    if ((e.optional == false &&
                                            string!.trim().isEmpty &&
                                            e.isEmpty == false &&
                                            e.name != 'Postcode / Zipcode') ||
                                        e.forceInvalidate ||
                                        (e.invalidEmail == true &&
                                            !invalidEmail(string))) {
                                      return e.errorMsg;
                                    }

                                    return null;
                                  },
                                  autovalidateMode: e.autovalidateMode ??
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    fillColor: AppColors.WHITE,
                                    // filled: true,
                                    hintStyle: AppTextStyle.Grey16_9E9E9E,
                                    hintText: e.placeorderName ?? '',
                                    errorStyle: const TextStyle(fontSize: 12),
                                    errorMaxLines: 3,
                                    // contentPadding: EdgeInsets.fromLTRB(
                                    //     0, 12.h, 12.w, 12.h),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(0, 4, 12, 0),
                                    // border: UnderlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //       color: e.lineColor ??
                                    //           AppColors.GREY_E0E0E0),
                                    // ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: e.lineColor ??
                                              (e.controller!.text.isNotEmpty
                                                  ? AppColors.GREY_9E9E9E
                                                  : AppColors.GREY_BDBDBD)),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: e.lineColor ??
                                              (e.controller!.text.isNotEmpty
                                                  ? AppColors.GREY_9E9E9E
                                                  : AppColors.GREY_BDBDBD)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: e.lineColor ??
                                              AppColors.GREY_9E9E9E),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: e.errorLineColor ??
                                              AppColors.RED_CB0000),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: e.errorLineColor ??
                                              AppColors.RED_CB0000),
                                    ),
                                  ),
                                  // keyboardType: e.keyboardIsNum
                                  //     ? TextInputType.number
                                  //     : TextInputType.text,
                                  keyboardType: e.textInputType,
                                  focusNode: e.focusNode,
                                ),
                                if (e.prefixIcon != null)
                                  Positioned(
                                    left: 0,
                                    child: e.prefixIcon!,
                                  ),
                                if (e.suffixIcon != null)
                                  Positioned(
                                    right: 0,
                                    child: e.suffixIcon!,
                                  ),
                                if (e.onTap != null)
                                  Container(
                                    width: constrains.maxWidth,
                                    height: 40,
                                    color: const Color.fromARGB(0, 0, 0, 0),
                                    child: const SizedBox(),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    });
  }
}
