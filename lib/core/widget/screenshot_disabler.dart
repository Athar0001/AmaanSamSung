// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:amaan_tv/core/provider/screenshot_provider.dart';
// import 'package:provider/provider.dart';

// class ScreenshotDisabler extends StatefulWidget {
//   const ScreenshotDisabler({required this.child, super.key});

//   final Widget child;

//   @override
//   State<ScreenshotDisabler> createState() => _ScreenshotDisablerState();
// }

// class _ScreenshotDisablerState extends State<ScreenshotDisabler> {
//   late final _screenshotProvider = context.read<ScreenshotProvider>();

//   @override
//   void initState() {
//     super.initState();
//     // _disableScreenshot();
//   }

//   @override
//   void dispose() {
//     _enableScreenshot();
//     super.dispose();
//   }

//   Future<void> _disableScreenshot() async {
//     log('disableScreenshot', name: 'ScreenshotDisabler');
//     final disableScreenshot = await _screenshotProvider.disableScreenshot();
//     log('disableScreenshot: $disableScreenshot', name: 'ScreenshotDisabler');
//   }

//   Future<void> _enableScreenshot() async {
//     log('enableScreenshot', name: 'ScreenshotDisabler');
//     final enableScreenshot = await _screenshotProvider.enableScreenshot();
//     log('enableScreenshot: $enableScreenshot', name: 'ScreenshotDisabler');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
