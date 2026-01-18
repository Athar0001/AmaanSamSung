import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/show_detials_poster.dart';
import 'package:amaan_tv/core/widget/buttons/player_button.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/services.dart';

class AnimatedShowButton extends StatefulWidget {
  const AnimatedShowButton({
    required this.model,
    required this.isLoading,
    required this.onTapShow,
    super.key,
  });

  final Details model;
  final bool isLoading;
  final VoidCallback onTapShow;

  @override
  State<AnimatedShowButton> createState() => _AnimatedShowButtonState();
}

class _AnimatedShowButtonState extends State<AnimatedShowButton> {
  final FocusNode _focusNode = FocusNode();
  double _scale = 1.0;

  void _animateAndExecute() {
    if (widget.isLoading) return;

    setState(() => _scale = 1.2);

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _scale = 1.0);
      widget.onTapShow();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: () {
        widget.onTapShow.call();
      },
      builder: (context, hasFocus) {
        return AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowButtonWidget(
                hasFocus: hasFocus,
                widget: ShowSeriesPoster(
                  model: widget.model,
                  isLoading: widget.isLoading,
                  onTapShow: widget.onTapShow,
                  refresh: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
