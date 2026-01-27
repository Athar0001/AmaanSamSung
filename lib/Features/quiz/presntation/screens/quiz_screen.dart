import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/quiz/data/model/answer_question_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/quiz_questions_model/child_exam_question.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/answer_widget_args.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/anwser_widget_factory.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/linear_progress_widget.dart';
import 'package:amaan_tv/Features/quiz/provider/quiz_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.examId});

  final String examId;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool? isCorrect;
  bool isLoading = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().getQuizQuestions(examId: widget.examId);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  List<ChildExamQuestion> get questions =>
      context.read<QuizProvider>().quizQuestionsModel?.childExamQuestions ?? [];

  ChildExamQuestion? get currentQuestion =>
      questions.isNotEmpty ? questions[currentQuestionIndex] : null;

  void _onAnswerSelected(int index) async {
    if (isLoading || isCorrect != null) return;

    final provider = context.read<QuizProvider>();
    final question = currentQuestion;
    if (question == null) return;

    final answer = question.question?.questionAnswers?[index];
    if (answer == null) return;

    setState(() {
      selectedAnswerIndex = index;
      isLoading = true;
    });

    final answerModel = AnswerQuestionModel(
      questionId: question.questionId ?? '',
      childExamQuestionId: question.id ?? '',
      childExamQuestionAnswerId: answer.id ?? '',
    );

    final success = await provider.answerQuestion(answerModel);

    if (success && mounted) {
      final correct = answer.score > 0;
      setState(() {
        isCorrect = correct;
        isLoading = false;
      });

      if (correct) {
        _confettiController.play();
      }

      // Wait for feedback then advance
      await Future.delayed(const Duration(milliseconds: 1500));

      if (mounted) {
        if (currentQuestionIndex < questions.length - 1) {
          setState(() {
            currentQuestionIndex++;
            selectedAnswerIndex = -1;
            isCorrect = null;
          });
        } else {
          // Quiz completed
          context.pushReplacementNamed(
            AppRoutes.quizScore.name,
            pathParameters: {'examId': widget.examId},
          );
        }
      }
    } else if (mounted) {
      setState(() {
        isLoading = false;
        selectedAnswerIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsNew.scaffoldDarkColor,
      body: Stack(
        children: [
          Consumer<QuizProvider>(
            builder: (context, provider, _) {
              if (provider.stateGetQuizQuestions == AppState.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.stateGetQuizQuestions == AppState.error ||
                  questions.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalization.strings.noQuestions,
                        style: TextStyle(
                          color: AppColorsNew.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TvClickButton(
                        onTap: () => context.pop(),
                        focusBorderColor: AppColorsNew.primary,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColorsNew.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            AppLocalization.strings.ok,
                            style: TextStyle(
                              color: AppColorsNew.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              final question = currentQuestion;
              if (question == null) return const SizedBox();

              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Progress bar
                    LinearProgressWidget(
                      currentIndex: currentQuestionIndex,
                      totalQuestions: questions.length,
                    ),
                    const SizedBox(height: 30),
                    // Question Image
                    if (question.question?.attachment?.presignedUrl != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl:
                                question.question!.attachment!.presignedUrl!,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // Question Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        question.question?.text ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColorsNew.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Answer Options
                    if (question.question?.questionAnswers != null)
                      Expanded(
                        child: AnswerWidgetFactory.create(
                          questionType: question.question!.questionType,
                          args: AnswerWidgetArgs(
                            selectedIndex: selectedAnswerIndex,
                            isCorrect: isCorrect,
                            childExamQuestionAnswers:
                                question.question!.questionAnswers!,
                            onTap: _onAnswerSelected,
                          ),
                        ),
                      ),
                    // Loading Indicator
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    // Feedback
                    if (isCorrect != null)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          isCorrect!
                              ? AppLocalization.strings.right
                              : AppLocalization.strings.wrong,
                          style: TextStyle(
                            color: isCorrect! ? Colors.green : Colors.red,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
