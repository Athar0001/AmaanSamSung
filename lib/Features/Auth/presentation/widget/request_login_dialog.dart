import 'package:flutter/material.dart';

class RequestLoginDialog extends StatelessWidget {
  const RequestLoginDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (_) => const RequestLoginDialog());
  }

  @override
  Widget build(BuildContext context) {
    return const Dialog(child: Text('Login Required'));
  }
}
