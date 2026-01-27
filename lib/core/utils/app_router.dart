import 'package:amaan_tv/Features/Auth/presentation/widget/qr_login_screen.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/Features/Home/presentation/screens/categories_screen.dart';
import 'package:amaan_tv/Features/characters/presentation/screens/character_screen.dart';
import 'package:amaan_tv/Features/favorite/presentation/screens/favorite_screen.dart';
import 'package:amaan_tv/Features/quiz/presntation/screens/leader_board_screen.dart';
import 'package:amaan_tv/Features/quiz/presntation/screens/postponed_quizzes_screen.dart';
import 'package:amaan_tv/Features/quiz/presntation/screens/quiz_score_screen.dart';
import 'package:amaan_tv/Features/quiz/presntation/screens/quiz_screen.dart';
import 'package:amaan_tv/Features/quiz/provider/quiz_provider.dart';
import 'package:amaan_tv/Features/search/presentation/screens/search_screen.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/utils/route_extra_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/Features/Home/presentation/screens/home_screen.dart';
import 'package:amaan_tv/Features/Home/presentation/screens/show_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/search/provider/search_provider.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart' as di;

import '../../Features/Home/data/models/home/show_details_model/data.dart';
import '../../Features/Home/presentation/screens/show_player.dart';
import 'cash_services/cashe_helper.dart';

// Definition of AppRoutes as an Enum to support .routeName and strict typing
enum AppRoutes {
  home('home'),
  showDetails('showDetails'),
  categories('categories'),
  soonRadio('soonRadio'),
  reels('reels'),
  showPlayer('showPlayer'), // Stub
  notifications('notifications'),
  // Missing routes added to satisfy compilation
  radio('radio'),
  soonStories('soonStories'),
  search('search'),
  parentSettingsSubscription('parentSettingsSubscription'),
  // Favorite routes
  favorites('favorites'),

  homeChild('homeChild'),
  qrLogin('qrLogin'),
  // Quiz routes
  quiz('quiz'),
  quizScore('quizScore'),
  quizLeaderboard('quizLeaderboard'),
  postponedQuizzes('postponedQuizzes');

  final String name;
  const AppRoutes(this.name);
  String get routeName => name;
}

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: '/qr-login',
  redirect: (context, state) {
    final loginInfo = CacheHelper.getData(key: 'loginInfo');

    final isOnLogin = state.matchedLocation == '/qr-login';

    if (loginInfo != null && isOnLogin) {
      return '/home';
    }

    if (loginInfo == null && !isOnLogin) {
      return '/qr-login';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoutes.home.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/qr-login',
      name: AppRoutes.qrLogin.routeName,
      builder: (context, state) => const QRLoginScreen(),
    ),
    GoRoute(
      path: '/showDetails/:id',
      name: AppRoutes.showDetails.routeName,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ShowDetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: '/categories',
      name: AppRoutes.categories.routeName,
      builder: (context, state) =>
          CategoriesScreen(category: state.extra as Category),
    ),
    GoRoute(
      path: '/soonRadio',
      name: AppRoutes.soonRadio.routeName,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text("Radio Soon"))),
    ),
    GoRoute(
      path: '/notifications',
      name: AppRoutes.notifications.routeName,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text("Notifications"))),
    ),
    GoRoute(
      path: '/reels',
      name: AppRoutes.reels.routeName,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text("Reels"))),
    ),
    // Placeholder routes
    GoRoute(
      path: '/search',
      name: AppRoutes.search.routeName,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => di.sl<SearchProvider>(),
        child: SearchScreen(),
      ),
    ),
    GoRoute(
      path: '/character',
      name: 'character',
      builder: (context, state) {
        final character = state.extra as CharacterData?;

        if (character != null) {
          return CharacterScreen(character: character);
        }

        // Fallback if character data is not passed
        return Scaffold(body: Center(child: Text('Character not found')));
      },
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) {
        // Support both extra and query parameter sources for childId
        final String? childId =
            RouteExtraHelper.getNullableString(state.extra, 'childId') ??
                state.uri.queryParameters['childId'];
        return FavoriteScreen(childId: childId);
      },
    ),
    GoRoute(
      path: '/show-player',
      name: AppRoutes.showPlayer.routeName,
      pageBuilder: (context, state) {
        final url = RouteExtraHelper.getString(state.extra, 'url');
        final videoId = RouteExtraHelper.getString(state.extra, 'videoId');
        final show = RouteExtraHelper.getValue<Details>(state.extra, 'show');
        final repeatTimes =
            RouteExtraHelper.getNullableInt(state.extra, 'repeatTimes');
        final episodeId =
            RouteExtraHelper.getNullableString(state.extra, 'episodeId');
        final closingDuration =
            RouteExtraHelper.getNullableInt(state.extra, 'closingDuration');
        final fromMinute =
            RouteExtraHelper.getNullableString(state.extra, 'fromMinute');
        final episodesModel = RouteExtraHelper.getValue<List<Details>>(
            state.extra, 'episodesModel');
        final showRate =
            RouteExtraHelper.getBool(state.extra, 'showRate', true);

        if (show != null && url.isNotEmpty && videoId.isNotEmpty) {
          return NoTransitionPage(
            child: ShowPlayerScreen(
              url: url,
              show: show,
              videoId: videoId,
              repeatTimes: repeatTimes,
              episodeId: episodeId,
              closingDuration: closingDuration,
              fromMinute: fromMinute,
              episodesModel: episodesModel,
              showRate: showRate,
            ),
          );
        }

        // even error cases must return a Page
        return const NoTransitionPage(
          child: Scaffold(
            body: Center(child: Text('Invalid parameters')),
          ),
        );
      },
    ),
    // Quiz Routes
    GoRoute(
      path: '/quiz/:examId',
      name: AppRoutes.quiz.routeName,
      builder: (context, state) {
        final examId = state.pathParameters['examId']!;
        return ChangeNotifierProvider(
          create: (_) => di.sl<QuizProvider>(),
          child: QuizScreen(examId: examId),
        );
      },
    ),
    GoRoute(
      path: '/quiz-score/:examId',
      name: AppRoutes.quizScore.routeName,
      builder: (context, state) {
        final examId = state.pathParameters['examId']!;
        return ChangeNotifierProvider(
          create: (_) => di.sl<QuizProvider>(),
          child: QuizScoreScreen(examId: examId),
        );
      },
    ),
    GoRoute(
      path: '/quiz-leaderboard/:examId',
      name: AppRoutes.quizLeaderboard.routeName,
      builder: (context, state) {
        final examId = state.pathParameters['examId'];
        return ChangeNotifierProvider(
          create: (_) => di.sl<QuizProvider>(),
          child: LeaderBoardScreen(examId: examId),
        );
      },
    ),
    GoRoute(
      path: '/postponed-quizzes',
      name: AppRoutes.postponedQuizzes.routeName,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => di.sl<QuizProvider>(),
        child: const PostponedQuizzesScreen(),
      ),
    ),
  ],
);
