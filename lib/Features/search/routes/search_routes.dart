import 'package:amaan_tv/Features/search/presentation/screens/search_screen.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> searchRoutes = [
  GoRoute(
    path: '/search',
    name: AppRoutes.search.routeName,
    builder: (context, state) => const SearchScreen(),
  ),
];
