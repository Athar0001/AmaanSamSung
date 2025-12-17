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
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/languages/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.flavor = Flavor.values.firstWhere(
    (flavor) => flavor.name == appFlavor,
    orElse: () => Flavor.dev,
  );
  await CacheHelper.init();

  runApp(const AmaanTVApp());
}

class AmaanTVApp extends StatelessWidget {
  const AmaanTVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ), // Standard mobile size, adjust if needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserNotifier.instance),
            Provider<ApiService>(create: (_) => ApiService.getInstance()),
            ChangeNotifierProxyProvider2<
              ApiService,
              UserNotifier,
              HomeProvider
            >(
              create: (context) => HomeProvider(
                HomeService(ApiService.getInstance(), UserNotifier.instance),
                UserNotifier.instance,
              ),
              update: (context, apiService, userNotifier, previous) =>
                  previous ??
                  HomeProvider(
                    HomeService(apiService, userNotifier),
                    userNotifier,
                  ),
            ),
          ],
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
              // Initialize AppLocalization helper
              if (widget != null) {
                AppLocalization.initialize(context);
              }
              return widget!;
            },
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
