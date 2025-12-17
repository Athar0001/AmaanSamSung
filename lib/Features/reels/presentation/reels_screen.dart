import 'package:flutter/material.dart';

class ReelsScreen extends StatelessWidget {
  final List<dynamic>? reels;

  const ReelsScreen({super.key, this.reels});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Reels Feature Not Available on TV')),
    );
  }
}
