import 'package:amaan_tv/Features/favorite/presentation/screens/favorite_screen.dart';
import 'package:amaan_tv/core/utils/route_extra_helper.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> favoriteRoutes = [
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
];
