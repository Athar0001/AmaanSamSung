import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/presentation/screens/home_layout_screen.dart';

class HomeLayoutScreenChild extends StatelessWidget {
  const HomeLayoutScreenChild({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeLayoutScreen(isChild: true);
  }
}
