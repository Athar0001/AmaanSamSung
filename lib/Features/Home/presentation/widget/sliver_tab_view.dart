import 'package:flutter/material.dart';

/// A sliver that displays one child at a time based on a [TabController].
/// Similar to [TabBarView] but works with slivers in a [CustomScrollView].
class SliverTabBarView extends StatefulWidget {
  const SliverTabBarView({required this.children, super.key, this.controller});

  /// The sliver widgets to display in each tab.
  final List<Widget> children;

  /// The [TabController] that controls which tab is displayed.
  /// If null, uses [DefaultTabController].
  final TabController? controller;

  @override
  State<SliverTabBarView> createState() => _SliverTabBarViewState();
}

class _SliverTabBarViewState extends State<SliverTabBarView> {
  TabController? _controller;

  TabController? get controller =>
      widget.controller ?? _controller ?? _updateController();

  @override
  void didUpdateWidget(SliverTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateController();
  }

  TabController? _updateController() {
    final newController =
        widget.controller ?? DefaultTabController.maybeOf(context);
    if (newController == _controller) return _controller;

    _controller?.removeListener(_handleTabChange);
    _controller = newController;
    _controller?.addListener(_handleTabChange);

    return _controller;
  }

  void _handleTabChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;

    if (ctrl == null) {
      throw FlutterError(
        'No TabController found.\n'
        'SliverTabBarView requires a TabController. '
        'Typically this is done by using DefaultTabController.',
      );
    }

    final index = ctrl.index.clamp(0, widget.children.length - 1);
    return widget.children[index];
  }
}
