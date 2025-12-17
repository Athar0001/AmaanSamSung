import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/Features/Home/utils/advertisement_helper.dart';

class AdvertisementDialog extends StatelessWidget {
  const AdvertisementDialog({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.7.sh),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted && AdvertisementHelper.isAdvertisementShown) {
                log(
                  'Error loading image',
                  error: error,
                  name: 'AdvertisementDialog',
                );
                context.pop();
              }
            });
            return SizedBox.shrink();
          },
          imageBuilder: (context, imageProvider) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image(image: imageProvider, fit: BoxFit.contain),
                ),
                Positioned(
                  top: -15.h,
                  right: -15.w,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.black, size: 24.r),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
