import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/provider/bottom_bar_provider.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/layout_bottom_sheet.dart';
import 'package:amaan_tv/Features/Home/utils/advertisement_helper.dart';
import 'package:amaan_tv/core/utils/notification_navigation_service.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart' as di;

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key, this.isChild = false, this.initialIndex});

  final bool isChild;
  final int? initialIndex;

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  @override
  void initState() {
    super.initState();
    // Add backup check for pending notification navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationNavigationService().checkAndExecutePendingNavigation();
      AdvertisementHelper.checkAndShowAdvertisement(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      key: ValueKey(widget.isChild),
      create: (_) =>
          di.sl<BottomBarProvider>()
            ..changeIndex(index: (widget.initialIndex ?? 0)),
      child: Consumer<BottomBarProvider>(
        builder: (context, layoutProvider, child) {
          return ScaffoldGradientBackground(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            extendBody: true,
            // Add this line
            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                layoutProvider.changeIndex(index: 0);
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 550),
                child: layoutProvider.items[layoutProvider.currentIndex].screen,
              ),
            ),
            bottomNavigationBar: SafeArea(
              bottom: false,
              child: LayoutBottomSheet(layoutProvider: layoutProvider),
            ),
          );
        },
      ),
    );
  }
}
