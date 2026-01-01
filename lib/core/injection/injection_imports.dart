import 'package:get_it/get_it.dart';
import 'package:amaan_tv/Features/Home/provider/bottom_bar_provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/Features/family/provider/family_provider.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/services/signalr_service.dart';
import 'package:amaan_tv/Features/Home/data/data_source/home_service.dart';
import 'package:amaan_tv/Features/search/data/data_source/search_service.dart';
import 'package:amaan_tv/Features/search/provider/search_provider.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => UserNotifier.instance);
  sl.registerLazySingleton(() => ApiService.getInstance());
  sl.registerLazySingleton(() => SignalRService());
  sl.registerFactory(() => HomeService(sl(), sl()));

  sl.registerFactory(() => BottomBarProvider(sl()));
  sl.registerFactory(() => ShowProvider(sl(), sl()));
  sl.registerFactory(() => FamilyProvider());
  sl.registerFactory(() => SearchService(sl(), sl()));
  sl.registerFactory(() => SearchProvider(sl(), sl()));
}
