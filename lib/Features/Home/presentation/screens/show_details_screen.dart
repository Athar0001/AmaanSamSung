import 'package:flutter/material.dart';

class ShowDetailsScreen extends StatelessWidget {
  const ShowDetailsScreen({required this.id, super.key, this.fromMinute});

  final String id;
  final String? fromMinute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Show Details $id')),
      body: Center(
        child: Text('Show Details for ID: $id\n(Feature coming soon)'),
      ),
    );
  }
}
