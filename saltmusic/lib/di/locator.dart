import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:saltmusic/musicfeature/data/datasource/remote.dart';
import 'package:saltmusic/musicfeature/data/repository/repo.dart';
import 'package:saltmusic/musicfeature/domain/repo.dart';
import 'package:saltmusic/musicfeature/view/notifier.dart';
import 'package:saltmusic/network/network_requester.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpDI() async {
  BaseOptions options = BaseOptions(
    baseUrl: "https://itunes.apple.com",
    receiveDataWhenStatusError: true,
    sendTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    // 60 seconds
    receiveTimeout: const Duration(seconds: 25), // 60 seconds
  );

  var dio = Dio(options);
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<NetworkRequester>(
      () => NetworkRequester(dio: getIt()));
  getIt.registerLazySingleton<MusicRemoteDS>(
      () => MusicRemoteDSImpl(networkRequester: getIt()));

  // / / repo
  getIt.registerLazySingleton<MusicRepository>(
    () => MusicRepositoryImpl(
      remoteDatasource: getIt(),
    ),
  );

  // / Notifier
  getIt.registerLazySingleton<MusicNotifier>(
    () => MusicNotifier(),
  );
}
