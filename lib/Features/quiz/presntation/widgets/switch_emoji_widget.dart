import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/answer_widget_args.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class SwitchEmojiWidget extends StatelessWidget {
  const SwitchEmojiWidget({super.key, required this.args});

  final AnswerWidgetArgs args;

  @override
  Widget build(BuildContext context) {
    final answers = args.childExamQuestionAnswers;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(answers.length, (index) {
          final answer = answers[index];
          final isSelected = args.selectedIndex == index;
          final isCorrect = args.isCorrect;
          final isCorrectAnswer = answer.score > 0;

          Color borderColor;
          Color backgroundColor;

          if (isSelected && isCorrect != null) {
            borderColor = isCorrectAnswer ? Colors.green : Colors.red;
            backgroundColor = isCorrectAnswer
                ? Colors.green.withValues(alpha: .2)
                : Colors.red.withValues(alpha: .2);
          } else if (isSelected) {
            borderColor = AppColorsNew.primary;
            backgroundColor = AppColorsNew.primary.withValues(alpha: .2);
          } else {
            borderColor = Colors.grey.shade700;
            backgroundColor = Colors.transparent;
          }

          // Determine emoji based on answer text or default
          String emoji = answer.text ?? '';
          if (emoji.isEmpty) {
            emoji = index == 0 ? '✓' : '✗';
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TvClickButton(
              onTap: () => args.onTap(index),
              focusScale: 1.15,
              builder: (context, hasFocus) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: hasFocus ? AppColorsNew.primary : borderColor,
                      width: hasFocus ? 4 : 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(
                        fontSize: 48,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
