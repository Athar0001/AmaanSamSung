import 'package:amaan_tv/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/Features/Home/data/data_source/home_service.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/tv_focus_manager.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/languages/app_localizations.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';
import 'package:tizen_log/tizen_log.dart';
import 'package:toastification/toastification.dart';

import 'Features/Auth/provider/auth_provider.dart';
import 'Features/Home/provider/show_player_provider.dart';
import 'Features/Home/provider/time_provider.dart';
import 'core/Themes/styles.dart';
import 'package:toastification/toastification.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart' as di;
import 'package:amaan_tv/core/services/signalr_service.dart';

const String appFlavor = String.fromEnvironment(
  'appFlavor',
  defaultValue: 'dev',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  di.init();
  final userNotifier = di.sl<UserNotifier>();
  userNotifier.init();
  AppFlavor.flavor = Flavor.values.firstWhere(
    (flavor) => flavor.name == appFlavor,
    orElse: () => Flavor.dev,
  );
  runApp( TvNavigationProvider(
    child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => userNotifier),
          Provider<ApiService>(create: (_) => ApiService.getInstance()),
          ChangeNotifierProvider(create: (_) => di.sl<TimeProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<ShowPlayerProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
          ChangeNotifierProxyProvider2<ApiService, UserNotifier,
              HomeProvider>(
            create: (context) => HomeProvider(
              HomeService(ApiService.getInstance(), userNotifier),
              userNotifier,
            ),
            update: (context, apiService, _, previous) =>
            previous ??
                HomeProvider(
                  HomeService(apiService, userNotifier),
                  userNotifier,
                ),
          ),
        ],
        child: const AmaanTVApp()),
  ));
}


class AmaanTVApp extends StatelessWidget {
  const AmaanTVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        1920,
        1080,
      ), // Standard mobile size, adjust if needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ToastificationWrapper(
          child: MaterialApp.router(
            title: 'Amaan TV',
            debugShowCheckedModeBanner: false,
            // Localization Setup
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('ar'),
            // Default to Arabic as per typical requirement, or en
            builder: (context, widget) {
              if (widget != null) {
                AppLocalization.initialize(context);
              }
              // final wrapped = Shortcuts(
              //   shortcuts: <LogicalKeySet, Intent>{
              //     LogicalKeySet(LogicalKeyboardKey.arrowLeft): const DirectionalFocusIntent(TraversalDirection.left),
              //     LogicalKeySet(LogicalKeyboardKey.arrowRight): const DirectionalFocusIntent(TraversalDirection.right),
              //     LogicalKeySet(LogicalKeyboardKey.arrowUp): const DirectionalFocusIntent(TraversalDirection.up),
              //     LogicalKeySet(LogicalKeyboardKey.arrowDown): const DirectionalFocusIntent(TraversalDirection.down),
              //     LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              //     LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
              //   },
              //   child: Actions(
              //     actions: <Type, Action<Intent>>{
              //       DirectionalFocusIntent: DirectionalFocusAction(),
              //     },
              //     child: widget!,
              //   ),
              // );
              //
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   if (FocusManager.instance.primaryFocus == null) {
              //     TvFocusManager.instance.restoreFocus(context);
              //   }
              // });

              return widget!;
            },
            themeMode: ThemeMode.dark,
            // themeMode: provider.themeMode,
            theme: KidsAppTheme.instance.lightTheme(),
            darkTheme: KidsAppTheme.instance.darkTheme(),
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
