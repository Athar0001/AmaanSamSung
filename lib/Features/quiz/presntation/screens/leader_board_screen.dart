import 'package:amaan_tv/Features/quiz/data/model/top_ten_model.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/list_items_widget.dart';
import 'package:amaan_tv/Features/quiz/presntation/widgets/stage_item_widget.dart';
import 'package:amaan_tv/Features/quiz/provider/quiz_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key, this.examId});

  final String? examId;

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().getTopTen(examId: widget.examId);
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
              if (provider.topTenState == AppState.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              final topTen = provider.topTenModel?.data ?? [];

              if (topTen.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalization.strings.noPostponedQuizzes,
                    style: TextStyle(
                      color: AppColorsNew.white,
                      fontSize: 20,
                    ),
                  ),
                );
              }

              final topThree = topTen.take(3).toList();
              final rest = topTen.length > 3 ? topTen.sublist(3) : <ChildModel>[];

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      // Title
                      Row(
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
                            AppLocalization.strings.leaderBoard,
                            style: TextStyle(
                              color: AppColorsNew.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Top 3 Podium
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // 2nd place
                          if (topThree.length > 1)
                            StageItemWidget(child: topThree[1], rank: 2),
                          const SizedBox(width: 16),
                          // 1st place
                          if (topThree.isNotEmpty)
                            StageItemWidget(child: topThree[0], rank: 1),
                          const SizedBox(width: 16),
                          // 3rd place
                          if (topThree.length > 2)
                            StageItemWidget(child: topThree[2], rank: 3),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Rest of the list
                      if (rest.isNotEmpty)
                        ListItemsWidget(
                          children: rest,
                          startRank: 4,
                        ),
                      const SizedBox(height: 30),
                      // Continue Button
                      TvClickButton(
                        onTap: () => context.pop(),
                        focusBorderColor: AppColorsNew.primary,
                        focusScale: 1.05,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColorsNew.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            AppLocalization.strings.continueLabel,
                            style: TextStyle(
                              color: AppColorsNew.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                Colors.amber,
                Colors.orange,
                Colors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
