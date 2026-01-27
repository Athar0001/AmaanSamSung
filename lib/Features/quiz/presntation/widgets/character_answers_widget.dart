import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/answer_widget_args.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class CharacterAnswersWidget extends StatelessWidget {
  const CharacterAnswersWidget({super.key, required this.args});

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

          if (isSelected && isCorrect != null) {
            borderColor = isCorrectAnswer ? Colors.green : Colors.red;
          } else if (isSelected) {
            borderColor = AppColorsNew.primary;
          } else {
            borderColor = Colors.transparent;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TvClickButton(
              onTap: () => args.onTap(index),
              focusScale: 1.1,
              builder: (context, hasFocus) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 150,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: hasFocus ? AppColorsNew.primary : borderColor,
                      width: hasFocus ? 4 : 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (answer.attachment?.presignedUrl != null)
                          CachedNetworkImage(
                            imageUrl: answer.attachment!.presignedUrl!,
                            fit: BoxFit.cover,
                          )
                        else
                          Container(
                            color: Colors.grey.shade800,
                            child: Center(
                              child: Text(
                                answer.text ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColorsNew.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        if (isSelected && isCorrect != null)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:
                                    isCorrectAnswer ? Colors.green : Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isCorrectAnswer ? Icons.check : Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
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
