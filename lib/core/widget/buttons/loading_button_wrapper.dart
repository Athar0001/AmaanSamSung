import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingButtonWrapper extends StatefulWidget {
  const LoadingButtonWrapper({
    required this.builder,
    super.key,
    this.onPressed,
  });

  final Future<void> Function()? onPressed;

  final Widget Function(
      BuildContext context,
      Future<void> Function()? onPressed,
      )
  builder;

  @override
  State<LoadingButtonWrapper> createState() => _LoadingButtonWrapperState();
}

class _LoadingButtonWrapperState extends State<LoadingButtonWrapper> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.onPressed?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return SizedBox(
      height: 50.r,
      width: 100.r,
      child: UnconstrainedBox(
        child: SizedBox(
          width: 50.r,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulseSync,
            strokeWidth: 2,
            colors: [AppColorsNew.primary, AppColorsNew.amber2],
          ),
        ),
      ),
    );
    return widget.builder(
      context,
      widget.onPressed == null ? null : _onPressed,
    );
  }
}

