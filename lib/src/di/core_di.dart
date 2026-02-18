import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../data/data_sources/remote/zeroclaw_rest_api.dart';

void registerCoreDependencies(GetIt getIt) {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => ZeroClawRestApi());
}

