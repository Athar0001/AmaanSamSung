import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';

class BannerImage extends StatelessWidget {

  const BannerImage({
    required this.imageUrl, super.key,
    this.fit = BoxFit.cover,
    this.showGradient = true,
    this.blurSigma,
  });
  final String? imageUrl;
  final BoxFit fit;
  final bool showGradient;
  final double? blurSigma;

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImageHelper(
      width: double.infinity,
      height: double.infinity,
      imageUrl: imageUrl ?? '',
      fit: fit,
    );

    if (blurSigma != null) {
      image = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurSigma!, sigmaY: blurSigma!),
        child: image,
      );
    }

    if (showGradient) {
      image = Stack(
        children: [
          image,
          GradientHomePoster(
            borderRadius: 0,
          ),
        ],
      );
    }

    return image;
  }
}
