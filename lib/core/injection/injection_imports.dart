import 'package:get_it/get_it.dart';
import 'package:amaan_tv/Features/Home/provider/bottom_bar_provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/Features/family/provider/family_provider.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => UserNotifier.instance);
  sl.registerFactory(() => BottomBarProvider(sl()));
  sl.registerFactory(() => ShowProvider());
  sl.registerFactory(() => FamilyProvider());
}
