import 'package:flutter/material.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/theme/styles/styles.dart';

class AddressItem extends StatelessWidget {
  final AddressModel address;
  final TextStyle textStyle;
  final bool showPhone;
  final bool fromProfile;

  const AddressItem(this.address,
      {Key? key,
      this.textStyle = AppTextStyle.Black14,
      this.showPhone = true,
      this.fromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${address.firstName} ${address.lastName}',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${address.address1}${(address.address2 != null && address.address2!.isNotEmpty) ? ' ${address.address2}' : ''}, ${address.city}',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${(address.province != null && address.province!.isNotEmpty) ? '${address.province}, ' : ''}${address.zip}, ${address.country}',
          style: textStyle,
        ),
        if (showPhone)
          Offstage(
            offstage: !(address.phone != null && address.phone!.isNotEmpty),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '${address.phone}',
                style: textStyle,
              ),
            ),
          )
      ],
    );
  }
}
