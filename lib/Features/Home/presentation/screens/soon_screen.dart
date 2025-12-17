import 'package:flutter/material.dart';

class SoonScreen extends StatelessWidget {
  final bool backButton;
  const SoonScreen({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButton ? AppBar() : null,
      body: const Center(child: Text('Coming Soon')),
    );
  }
}
