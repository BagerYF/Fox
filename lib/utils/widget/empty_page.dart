import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? callback;
  const EmptyPage(
      {Key? key,
      required this.title,
      this.buttonText = 're-try',
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.Black16,
        ),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            callback?.call();
          },
          child: Container(
            width: 132,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(color: AppColors.BLACK, width: 1),
            ),
            child: Text(
              buttonText,
              style: AppTextStyle.Black12,
            ),
          ),
        ),
      ],
    );
  }
}
