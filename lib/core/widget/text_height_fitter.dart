import 'package:flutter/material.dart';

class TextHeightFitter extends StatelessWidget {

  const TextHeightFitter({
    required this.text, required this.style, required this.maxWidth, super.key,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  });
  final String text;
  final TextStyle style;
  final int maxLines;
  final TextAlign textAlign;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    // Calculate the height needed for the text with the given constraints
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      maxLines: maxLines,
    );

    // Layout with the maximum width constraint
    textPainter.layout(maxWidth: maxWidth);

    // Get the height needed
    final textHeight = textPainter.height;

    return SizedBox(
      width: maxWidth,
      height: textHeight,
      child: FittedBox(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: maxWidth,
          child: Text(
            text,
            style: style,
            maxLines: maxLines,
            textAlign: textAlign,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }
}
