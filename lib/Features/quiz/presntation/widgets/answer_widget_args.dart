import 'package:amaan_tv/Features/quiz/data/model/quiz_questions_model/question_answer.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class AnswerWidgetArgs {
  const AnswerWidgetArgs({
    required this.selectedIndex,
    required this.isCorrect,
    required this.childExamQuestionAnswers,
    required this.onTap,
    this.attachment,
  });
  final int selectedIndex;
  final bool? isCorrect;
  final List<QuestionAnswer> childExamQuestionAnswers;
  final void Function(int index) onTap;
  final ForgroundImage? attachment;
}
