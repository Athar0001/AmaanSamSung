import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/answer_widget_args.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class GridViewAnswersWidget extends StatelessWidget {
  const GridViewAnswersWidget({super.key, required this.args});

  final AnswerWidgetArgs args;

  @override
  Widget build(BuildContext context) {
    final answers = args.childExamQuestionAnswers;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: answers.length >= 4 ? 2 : answers.length,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3.5,
        ),
        itemCount: answers.length,
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
            focusScale: 1.05,
            builder: (context, hasFocus) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasFocus ? AppColorsNew.primary : borderColor,
                    width: hasFocus ? 3 : 2,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (answer.attachment?.presignedUrl != null) ...[
                          CachedNetworkImage(
                            imageUrl: answer.attachment!.presignedUrl!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                        ],
                        Flexible(
                          child: Text(
                            answer.text ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColorsNew.white,
                              fontSize: 18,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
