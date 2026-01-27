import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/quiz_summary_widget.dart';
import 'package:amaan_tv/Features/quiz/provider/quiz_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class QuizScoreScreen extends StatefulWidget {
  const QuizScoreScreen({super.key, required this.examId});

  final String examId;

  @override
  State<QuizScoreScreen> createState() => _QuizScoreScreenState();
}

class _QuizScoreScreenState extends State<QuizScoreScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().getExamScore(examId: widget.examId);
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsNew.scaffoldDarkColor,
      body: Stack(
        children: [
          Consumer<QuizProvider>(
            builder: (context, provider, _) {
              if (provider.examScoreState == AppState.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              final score = provider.examScoreModel?.data;

              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Success Icon
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Colors.amber,
                            size: 80,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Congratulations
                        Text(
                          AppLocalization.strings.youSucceeded,
                          style: TextStyle(
                            color: AppColorsNew.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Score
                        if (score != null) ...[
                          Text(
                            '${AppLocalization.strings.youHaveGot} ${score.totalScore} ${AppLocalization.strings.point}',
                            style: TextStyle(
                              color: AppColorsNew.white.withValues(alpha: 0.9),
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Stats
                          QuizSummaryWidget(
                            totalQuestions: (score.correctAnswers ?? 0) +
                                (score.wrongAnswers ?? 0),
                            correctAnswers: score.correctAnswers ?? 0,
                            wrongAnswers: score.wrongAnswers ?? 0,
                          ),
                        ],
                        const SizedBox(height: 40),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Leaderboard Button
                            TvClickButton(
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.quizLeaderboard.name,
                                  pathParameters: {'examId': widget.examId},
                                );
                              },
                              focusBorderColor: AppColorsNew.primary,
                              focusScale: 1.05,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                decoration: BoxDecoration(
                                  color: AppColorsNew.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  AppLocalization.strings.leaderBoard,
                                  style: TextStyle(
                                    color: AppColorsNew.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            // Try Again Button
                            TvClickButton(
                              onTap: () async {
                                final newExam = await context
                                    .read<QuizProvider>()
                                    .retakeExam(examId: widget.examId);
                                if (newExam != null && context.mounted) {
                                  context.pushReplacementNamed(
                                    AppRoutes.quiz.name,
                                    pathParameters: {
                                      'examId': newExam.id ?? ''
                                    },
                                  );
                                }
                              },
                              focusBorderColor: Colors.orange,
                              focusScale: 1.05,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.orange, width: 2),
                                ),
                                child: Text(
                                  AppLocalization.strings.tryAgain,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Continue Button
                        TvClickButton(
                          onTap: () => context.pop(),
                          focusBorderColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              AppLocalization.strings.continueLabel,
                              style: TextStyle(
                                color:
                                    AppColorsNew.white.withValues(alpha: 0.7),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                Colors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
