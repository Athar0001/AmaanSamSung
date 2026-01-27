import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/quiz/data/model/child_exam_model/child_exam_model.dart';
import 'package:amaan_tv/Features/quiz/provider/quiz_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class PostponedQuizzesScreen extends StatefulWidget {
  const PostponedQuizzesScreen({super.key});

  @override
  State<PostponedQuizzesScreen> createState() => _PostponedQuizzesScreenState();
}

class _PostponedQuizzesScreenState extends State<PostponedQuizzesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().postponedQuizzes(refresh: true);
    });
  }

  void _onQuizTap(ChildExamModel exam) async {
    final provider = context.read<QuizProvider>();

    if (exam.status.isCompleted) {
      // Retake exam
      final newExam = await provider.retakeExam(examId: exam.id ?? '');
      if (newExam != null && mounted) {
        context.pushNamed(
          AppRoutes.quiz.name,
          pathParameters: {'examId': newExam.id ?? ''},
        );
      }
    } else {
      // Start or continue exam
      context.pushNamed(
        AppRoutes.quiz.name,
        pathParameters: {'examId': exam.id ?? ''},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsNew.scaffoldDarkColor,
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            if (provider.postponedQuizzesState == AppState.loading &&
                provider.quizzesModel == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final quizzes = provider.quizzesModel?.data?.all ?? [];

            if (quizzes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 80,
                      color: AppColorsNew.white.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalization.strings.noPostponedQuizzes,
                      style: TextStyle(
                        color: AppColorsNew.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TvClickButton(
                      onTap: () => context.pop(),
                      focusBorderColor: AppColorsNew.primary,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
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

            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      TvClickButton(
                        onTap: () => context.pop(),
                        focusBorderColor: AppColorsNew.primary,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColorsNew.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        AppLocalization.strings.postponedQuizzes,
                        style: TextStyle(
                          color: AppColorsNew.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Quiz List
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: quizzes.length,
                    itemBuilder: (context, index) {
                      // Load more when near end
                      if (index == quizzes.length - 3) {
                        provider.loadPageForIndex(index);
                      }

                      final quiz = quizzes[index];

                      return TvClickButton(
                        onTap: () => _onQuizTap(quiz),
                        focusBorderColor: AppColorsNew.primary,
                        focusScale: 1.05,
                        builder: (context, hasFocus) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: hasFocus
                                    ? AppColorsNew.primary
                                    : Colors.grey.shade700,
                                width: hasFocus ? 3 : 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Quiz Image
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child:
                                        quiz.exam?.attachment?.presignedUrl !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: quiz.exam!.attachment!
                                                    .presignedUrl!,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                color: Colors.grey.shade800,
                                                child: Icon(
                                                  Icons.quiz,
                                                  size: 50,
                                                  color: AppColorsNew.white
                                                      .withValues(alpha: 0.5),
                                                ),
                                              ),
                                  ),
                                ),
                                // Quiz Info
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        quiz.exam?.name ?? '',
                                        style: TextStyle(
                                          color: AppColorsNew.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _StatusBadge(status: quiz.status),
                                          Text(
                                            '${quiz.exam?.noQuestions ?? 0} Q',
                                            style: TextStyle(
                                              color: AppColorsNew.white
                                                  .withValues(alpha: 0.7),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final ChildExamStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case ChildExamStatus.completed:
        color = Colors.green;
        break;
      case ChildExamStatus.notCompleted:
        color = Colors.orange;
        break;
      case ChildExamStatus.notStarted:
        color = AppColorsNew.primary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.button,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
