import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/quiz/data/model/quiz_questions_model/question.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/answer_widget_args.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/grid_view_answer_widget.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/list_view_answer_widget.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/character_answers_widget.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/switch_emoji_widget.dart';

class AnswerWidgetFactory {
  static Widget create({
    required QuestionType questionType,
    required AnswerWidgetArgs args,
  }) {
    switch (questionType) {
      case QuestionType.text:
      case QuestionType.gridView:
        return GridViewAnswersWidget(args: args);
      case QuestionType.listView:
        return ListViewAnswerWidget(args: args);
      case QuestionType.character:
        return CharacterAnswersWidget(args: args);
      case QuestionType.switchEmoji:
        return SwitchEmojiWidget(args: args);
    }
  }
}
