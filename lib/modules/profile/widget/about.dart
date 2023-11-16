import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "About",
      ),
      body: ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 18, bottom: 24),
                alignment: Alignment.center,
                child: const Text(
                  'The Best of Luxury Fashion',
                  style: AppTextStyle.Black20,
                ),
              ),
              Image.asset('lib/theme/assets/images/about.jpeg'),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                alignment: Alignment.topCenter,
                child: const Column(
                  children: [
                    Text(
                        'Shopify brings to you the best of luxury fashion. Featuring an extensive range of over 500 brands, including womenswear, menswear and kidswear from iconic fashion houses, such as Prada, Gucci, Saint Laurent, Balenciaga and Valentino.',
                        style: TextStyle(
                            color: AppColors.BLACK,
                            fontSize: 16,
                            height: 25.6 / 16)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Every aspect of the user experience is optimized, starting with a curated selection of world-renowned brands delivered with best-in-class technology. Payment is easy and secure, with free express shipping to over X countries and free returns on all orders so you can shop with confidence. ',
                        style: TextStyle(
                            color: AppColors.BLACK,
                            fontSize: 16,
                            height: 25.6 / 16)),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
