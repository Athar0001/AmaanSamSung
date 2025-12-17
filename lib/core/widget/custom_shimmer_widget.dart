import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShimmerLoading extends StatelessWidget {
  const CustomShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(50),
      child: Column(
        children: [
          Row(
            children: [
              CircleSkeleton(size: 30.h),
              SizedBox(width: 16.w),
              Skeleton(width: 230.w),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleSkeleton(size: 30.h),
              SizedBox(width: 16.w),
              Skeleton(width: 200.w),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleSkeleton(size: 30.h),
              SizedBox(width: 16.w),
              Skeleton(width: 150.w),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleSkeleton(size: 30.h),
              SizedBox(width: 16.w),
              Skeleton(width: 175.w),
            ],
          ),
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(20),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(20),
        shape: BoxShape.circle,
      ),
    );
  }
}
