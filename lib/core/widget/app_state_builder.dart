import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/utils/widget_sliver_extension.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:provider/provider.dart';

void _initState<T>(T _) {}

class AppStateBuilder<T extends ChangeNotifier, D> extends StatefulWidget {
  const AppStateBuilder({
    required this.state,
    required this.selector,
    required this.builder,
    super.key,
    void Function(T provider)? initState,
    this.child,
    this.provider,
    this.onDispose,
    this.isSliver = false,
  }) : initState = initState ?? _initState;

  final T? provider;
  final Widget? child;

  final bool isSliver;

  final AppState Function(T provider) state;

  final void Function(T provider) initState;

  final D? Function(T provider) selector;

  final void Function(T provider)? onDispose;

  final Widget Function(BuildContext context, D data, Widget? child) builder;

  @override
  State<AppStateBuilder<T, D>> createState() => _AppStateBuilderState<T, D>();
}

class _AppStateBuilderState<T extends ChangeNotifier, D>
    extends State<AppStateBuilder<T, D>> {
  late T _provider;

  @override
  void dispose() {
    log('dispose called', name: 'AppStateBuilder');
    if (widget.onDispose != null) {
      widget.onDispose!(_provider);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<T, String>(
      child: widget.child,
      selector: (BuildContext, provider) {
        final selected = widget.selector(provider);
        final selectedList = selected is List ? selected.length.toString() : '';

        return widget.state(provider).toString() +
            selected.toString() +
            selectedList;
      },
      builder: (context, _, child) {
        final provider = context.read<T>();
        this._provider = provider;
        final state = widget.state(provider);
        switch (state) {
          case AppState.init:
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => widget.initState(provider),
            );
            return const SizedBox.shrink().isSliver(widget.isSliver);
          case AppState.loading:
            return const AppCircleProgressHelper().isSliver(widget.isSliver);
          case AppState.error:
            // Note: Error message not available in simple enum
            return Center(child: Text("Error").isSliver(widget.isSliver));
          case AppState.success:
            return widget.builder(context, widget.selector(provider)!, child);
        }
      },
    );
  }
}
