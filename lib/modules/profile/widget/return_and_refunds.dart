import 'package:flutter/material.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class ReturnAndRefunds extends StatelessWidget {
  ReturnAndRefunds({Key? key}) : super(key: key);

  final currency = ProfilePageController.to.region.currencyCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Return and Refunds",
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoScrollBehavior(),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                ),
                child: const Text(
                  'Returns',
                  style: AppTextStyle.BlackBold16,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Text(
                  '''You can purchase in confidence and send the items back to us if they are not right for you. If you would like to initiate a return, please go to your account at the top right corner where it says your name. Click "Create Return" next to the order you would like to return and follow the prompts. If you checked out as a guest, please contact customer service at customerservice@Shopify.com. In the event you need change the pickup time you will need to liaise directly with Shopify's preferred courier.
      
For orders placed after 23 February 2021, returns are free. Should you wish to return your product, all taxes and duties will be refunded and no return fee will be incurred. However, any original shipping charges (if applicable) will not be refunded.
      
For orders placed before 23 February 2021, taxes and duties will not be refunded and these orders will be subject to a return fee of $currency 25.
      
Returns must arrive at our location within 14 days from the date the parcel is received using the label provided by us. Items received after this period are accepted only at the discretion of Shopify. Please note that orders can only be cancelled within the first 24 hours of making a purchase provided that the item/s have not shipped. Any cancellations initiated after the 24 hour period has expired will incur a $currency 25 cancellation fee and any order which contains items that have been shipped may not be cancelled.
                  ''',
                  style: AppTextStyle.Black16,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                ),
                child: const Text(
                  'Refunds',
                  style: AppTextStyle.BlackBold16,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: const Text(
                  '''Once we receive the item, we will refund you to your original payment method. Please note that refunds may take up to 10 working days to process due to varying processing times between payment providers. ''',
                  style: AppTextStyle.Black16,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
