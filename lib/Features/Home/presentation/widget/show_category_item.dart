import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';


class ShowCategoryItemWidget extends StatefulWidget {
  const ShowCategoryItemWidget({
    required this.model, super.key,
    this.height,
    this.width,
  });

  final Details model;
  final double? height;
  final double? width;

  @override
  State<ShowCategoryItemWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ShowCategoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColorsNew.primary, width: 1.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.r),
            child: CachedNetworkImageHelper(
              imageUrl: widget.model.thumbnailImage?.url,
              cacheKey: widget.model.title,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
        GradientContainer(
          borderRadius: 12.r,
        ),

      ],
    );
  }
}
