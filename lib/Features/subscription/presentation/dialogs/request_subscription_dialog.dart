import 'package:flutter/material.dart';

class RequestSubscriptionsDialog extends StatelessWidget {
  const RequestSubscriptionsDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const RequestSubscriptionsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Dialog(child: Text('Subscription Required'));
  }
}
