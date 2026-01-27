import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/answer_widget_args.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class ListViewAnswerWidget extends StatelessWidget {
  const ListViewAnswerWidget({super.key, required this.args});

  final AnswerWidgetArgs args;

  @override
  Widget build(BuildContext context) {
    final answers = args.childExamQuestionAnswers;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: answers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final answer = answers[index];
          final isSelected = args.selectedIndex == index;
          final isCorrect = args.isCorrect;
          final isCorrectAnswer = answer.score > 0;

          Color borderColor;
          Color backgroundColor;

          if (isSelected && isCorrect != null) {
            if (isCorrectAnswer) {
              borderColor = Colors.green;
              backgroundColor = Colors.green.withValues(alpha: .2);
            } else {
              borderColor = Colors.red;
              backgroundColor = Colors.red.withValues(alpha: .2);
            }
          } else if (isSelected) {
            borderColor = AppColorsNew.primary;
            backgroundColor = AppColorsNew.primary.withValues(alpha: .2);
          } else {
            borderColor = Colors.grey.shade700;
            backgroundColor = Colors.transparent;
          }

          return TvClickButton(
            onTap: () => args.onTap(index),
            focusBorderColor: AppColorsNew.primary,
            focusScale: 1.02,
            builder: (context, hasFocus) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasFocus ? AppColorsNew.primary : borderColor,
                    width: hasFocus ? 3 : 2,
                  ),
                ),
                child: Row(
                  children: [
                    if (answer.attachment?.presignedUrl != null) ...[
                      CachedNetworkImage(
                        imageUrl: answer.attachment!.presignedUrl!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: Text(
                        answer.text ?? '',
                        style: TextStyle(
                          color: AppColorsNew.white,
                          fontSize: 18,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected && isCorrect != null)
                      Icon(
                        isCorrectAnswer ? Icons.check_circle : Icons.cancel,
                        color: isCorrectAnswer ? Colors.green : Colors.red,
                        size: 28,
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
