import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/show_detials_poster.dart';
import 'package:amaan_tv/core/widget/buttons/player_button.dart';

class AnimatedShowButton extends StatefulWidget {

  const AnimatedShowButton({
    required this.model, required this.isLoading, required this.onTapShow, super.key,
  });
  final Details model;
  final bool isLoading;
  final VoidCallback onTapShow;

  @override
  State<AnimatedShowButton> createState() => _AnimatedShowButtonState();
}

class _AnimatedShowButtonState extends State<AnimatedShowButton> {
  double _scale = 1.0;

  void _animateButton() {
    setState(() {
      _scale = 1.2; // Increase scale for pulse effect
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0; // Reset scale to original size
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animateButton();
        if (!widget.isLoading) {
          Future.delayed(Duration(milliseconds: 200), () {
            widget.onTapShow();
          });
        }
      },
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowButtonWidget(
              widget: ShowSeriesPoster(
                model: widget.model,
                isLoading: widget.isLoading,
                onTapShow: widget.onTapShow,
                refresh: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
