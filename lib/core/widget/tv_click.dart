

import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';

class TvClick extends StatelessWidget {
  final String id;
  final String? upId;
  final String? downId;
  final String? leftId;
  final String? rightId;
  final Widget child;
  final String? listBaseId;
  final VoidCallback? onSelect;
  final VoidCallback? onFocus;
  final bool autoFocus;
  final bool isList;
  final bool hasBorder;
  final int? index;
  final int? length;
  final double radius;
  final bool isCircle;
  final String? Function()? dynamicDownId;
  final String? Function()? dynamicLeftId;
  final String? Function()? dynamicRightId;

  const TvClick(
      {super.key,
      required this.id,
      required this.child,
      this.upId,
      this.downId,
      this.leftId,
      this.rightId,
      this.listBaseId,
      this.dynamicDownId,
      this.dynamicLeftId,
      this.dynamicRightId,
      this.onSelect,
      this.index,
      this.length,
      this.autoFocus = false,
      this.isList = false,
      this.hasBorder = true,
      this.isCircle = false,
      this.radius = 12,
      this.onFocus}) : assert(!isList || (index != null && length != null));

  @override
  Widget build(BuildContext context) {
    return TVFocusable(
        autofocus: autoFocus ,
        id: id,


        // upId: upId,
        // downId: downId,
        // rightId: !isList? rightId : index! > 0 ? '${id.substring(0, id.indexOf('_'))}_${index! - 1}' : null,
        // leftId: !isList? leftId : index! < length! ? '${id.substring(0, id.indexOf('_'))}_${index! + 1}' : '${id.substring(0, id.indexOf('_'))}_0',
        onFocus: onFocus,
        onSelect: (){
          onSelect?.call();
        },
        dynamicUpId: () {
          print(upId);
          return upId;
        },
        dynamicDownId: dynamicDownId ?? () {
          print(downId);
          return downId;
        },
        dynamicLeftId: dynamicLeftId ?? () {
          if (!isList) return leftId;
          if (index! < length!) {
            return '$listBaseId.item.${index! + 1}';
          }
          return null;
        },

        dynamicRightId: dynamicRightId ?? () {
          if (!isList) return rightId;
          if (index! > 0) {
            return '$listBaseId.item.${index! - 1}';
          }
          return null;
        },
        builder: (context, isFocused, _) {
          return AnimatedScale(
            scale: !hasBorder? 1.0 : isFocused ? 1.08 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: Container(
    decoration: BoxDecoration(
        borderRadius: isCircle? null : BorderRadius.circular(radius),
        shape: isCircle? BoxShape.circle : BoxShape.rectangle,
        border: hasBorder? Border.all(
            width: 2,
            color: isFocused ? AppColorsNew.white: Colors.transparent
        ) : null

    ),
    child: child,
            ),
          );
        },

    );
  }
}
