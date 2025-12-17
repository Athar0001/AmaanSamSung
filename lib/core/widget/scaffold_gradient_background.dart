import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'responsive_app_bar.dart';

class ScaffoldGradientBackground extends StatelessWidget {
  const ScaffoldGradientBackground({
    super.key,
    this.appBar,
    this.body,
    this.defulteAppBar = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.appBarLeadingWidth = 80.0,
  });
  final PreferredSizeWidget? appBar;
  final bool defulteAppBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  final DrawerCallback? onDrawerChanged;
  final DrawerCallback? onEndDrawerChanged;
  final AlignmentDirectional persistentFooterAlignment;
  final double? appBarLeadingWidth;

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final primaryColorLight = Theme.of(context).primaryColorLight;

    var processedAppBar = appBar;
    if (appBar is AppBar) {
      final appBarWidget = appBar as AppBar;
      processedAppBar = responsiveAppBar(
        context: context,
        title: appBarWidget.title,
        leading: appBarWidget.leading,

        actions: appBarWidget.actions,
        backgroundColor: appBarWidget.backgroundColor,
        // Add more properties as needed
      );
    }

    return Scaffold(
      appBar: defulteAppBar ? appBar : processedAppBar,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scaffoldBackgroundColor, primaryColorLight],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              bottom: -1.2.sh,
              right: -1.2.sw,
              child: Container(
                height: 50.r,
                width: 50.r,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColorsNew.primary3.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [Expanded(child: SizedBox(child: body))],
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: scaffoldBackgroundColor, // Use local variable
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
      onDrawerChanged: onDrawerChanged,
      onEndDrawerChanged: onEndDrawerChanged,
      persistentFooterAlignment: persistentFooterAlignment,
    );
  }
}
