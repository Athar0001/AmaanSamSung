import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final String categoryId;
  final String title;

  const CategoriesScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: Text('Categories Screen Stub')),
    );
  }
}
