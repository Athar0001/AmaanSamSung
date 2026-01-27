import 'package:flutter/material.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';

class LinearProgressWidget extends StatelessWidget {
  const LinearProgressWidget({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  final int currentIndex;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final progress =
        totalQuestions > 0 ? (currentIndex + 1) / totalQuestions : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          Text(
            '${currentIndex + 1}/$totalQuestions',
            style: TextStyle(
              color: AppColorsNew.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade700,
                valueColor: AlwaysStoppedAnimation<Color>(AppColorsNew.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
