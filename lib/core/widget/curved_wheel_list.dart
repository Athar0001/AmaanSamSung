import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurvedWheelList extends StatefulWidget {

  const CurvedWheelList({
    required this.itemBuilder, super.key,
    this.itemCount,
    this.height = 200,
    this.itemSize = 75,
    this.curveRadius = 400,
  });
  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final double height;
  final double itemSize;
  final double curveRadius;

  @override
  State<CurvedWheelList> createState() => _CurvedWheelListState();
}

class _CurvedWheelListState extends State<CurvedWheelList> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double calculateYPosition(double x) => -(x * x) * 0.8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: NotificationListener<ScrollNotification>(
        onNotification: (_) {
          setState(() {});
          return true;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportWidth = constraints.maxWidth;
            final itemWidth = widget.itemSize;
            var horizontalPadding = 0.0;

            // Calculate centering padding if needed
            if (widget.itemCount != null) {
              final totalWidth = widget.itemCount! * itemWidth;
              if (totalWidth < viewportWidth) {
                horizontalPadding = (viewportWidth - totalWidth) / 2;
              }
            }

            return ColoredBox(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 30.0.r,
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                child: ColoredBox(
                  color: Colors.transparent,
                  child: ListView.builder(
                    key: const Key('CurvedWheelList'),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.itemCount,
                    itemBuilder: (context, index) {
                      final scroll = _scrollController.hasClients
                          ? _scrollController.offset
                          : 0.0;
                      final itemOffset = (index * itemWidth) - scroll;

                      // Calculate position in physical viewport space
                      final viewportCenter = viewportWidth / 2;
                      final physicalPosition = horizontalPadding + itemOffset;
                      final relativePosition = (physicalPosition -
                              viewportCenter +
                              (itemWidth / 2)) /
                          viewportCenter;

                      final curveProgress =
                          calculateYPosition(relativePosition);
                      final dy = curveProgress * (widget.curveRadius * 0.10);

                      return Transform(
                        transform: Matrix4.identity()..translate(0.0, dy),
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.r),
                          child: SizedBox(
                            width: itemWidth,
                            child: widget.itemBuilder(context, index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
