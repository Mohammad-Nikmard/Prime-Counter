import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:prime_counter/repository/prime_remote_repository.dart';
import 'package:prime_counter/repository/prime_repository.dart';
import 'package:prime_counter/util/api_provider.dart';
import 'package:prime_counter/util/dio_handler.dart';
import 'package:prime_counter/util/prime_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;
Future<void> initServiceLocator() async {
  locator.registerSingleton<Dio>(DioHandler.getDio());

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<ApiProvider>(
    ApiProvider(dio: locator.get()),
  );

  locator.registerSingleton<PrimeManager>(
    PrimeManager(sharedPref: locator.get()),
  );

  locator.registerSingleton<PrimeRepository>(
    PrimeRemoteRepository(apiProvider: locator.get()),
  );
}
