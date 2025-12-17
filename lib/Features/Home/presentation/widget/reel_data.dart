import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/home/reals_model.dart';
// import 'package:amaan_tv/Features/Home/provider/reel_provider.dart';

class ReelData extends StatelessWidget {
  const ReelData({required this.reelsData, required this.index, super.key});
  final ReelModel reelsData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(reelsData.title ?? ''),
        Text(reelsData.description ?? ''),
      ],
    );
  }
}

class reelIcon extends StatelessWidget {
  // Kept to satisfy other references if any
  const reelIcon({required this.path, super.key, this.color});
  final String path;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
