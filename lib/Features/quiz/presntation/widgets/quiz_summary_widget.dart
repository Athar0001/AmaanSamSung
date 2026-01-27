import 'package:flutter/material.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';

class QuizSummaryWidget extends StatelessWidget {
  const QuizSummaryWidget({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.strings.statistics,
            style: TextStyle(
              color: AppColorsNew.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _StatRow(
            label: AppLocalization.strings.totalQuestions,
            value: totalQuestions.toString(),
            color: AppColorsNew.white,
          ),
          const SizedBox(height: 12),
          _StatRow(
            label: AppLocalization.strings.rightAnswers,
            value: correctAnswers.toString(),
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _StatRow(
            label: AppLocalization.strings.wrongAnswers,
            value: wrongAnswers.toString(),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColorsNew.white.withValues(alpha: 0.8),
            fontSize: 16,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
