import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';

enum CacheImageType {
  none,
  logo,
}

class AppCacheNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final CacheImageType type;

  const AppCacheNetworkImage(
      {Key? key,
      this.imageUrl,
      this.boxFit,
      this.width,
      this.height,
      this.type = CacheImageType.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.contains('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: boxFit,
        height: height,
        width: width,
        // placeholder: (
        //   BuildContext context,
        //   String url,
        // ) {
        //   return _placeHolder();
        // },
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) {
          return _errorWidget();
        },
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
      );
    } else {
      return _errorWidget();
    }
  }

  Widget _errorWidget() {
    if (type == CacheImageType.logo) {
      return SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Image.asset(
              LocalImages.asset("invalid_logo"),
            ),
          ));
    }
    return Container(
      height: height,
      width: width,
      color: AppColors.WHITE,
    );
  }
}
