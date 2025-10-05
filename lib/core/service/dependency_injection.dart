import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/data/data_sources/local_data_sources.dart';
import '../../features/data/data_sources/remote_data_sources.dart';
import '../../features/data/repositories/repository_impl.dart';
import '../../features/domain/repositories/repository.dart';
import '../../features/domain/use_cases/promotions_use_case/promotions_use_case.dart';
import '../../features/domain/use_cases/send_otp/send_otp_use_case.dart';
import '../../features/domain/use_cases/verify_otp_use_case/verify_otp_use_case.dart';
import '../../features/presentation/cubits/otp/otp_cubit.dart';
import '../../features/presentation/cubits/promotions_cubit/promotions_cubit.dart';
import '../network/api_helper.dart';
import '../network/network_info.dart';


final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton<ApiHelper>(() => ApiHelper(
    dio: sl(),
    source: sl(),
  ));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
    sl(),
  ));
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  /// Dio client
  sl.registerLazySingleton<Dio>(() => Dio());

  /// Data sources
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource(
    prefs: sl(),
    secureStorage: sl()
  ));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(apiHelper: sl()));
  /// Repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(
    localDataSource: sl(),
    networkInfo: sl(),
    remoteDataSource: sl()
  ));

  /// Cubit
  sl.registerFactory<OtpCubit>(() => OtpCubit(
    sendOtpUseCase: sl(),
    verifyOtpUseCase: sl(),
    source: sl(),
  ));
  sl.registerFactory<PromotionsCubit>(() => PromotionsCubit(
    getPromotionsUseCase: sl(),
  ));

  /// Use cases
  sl.registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton<GetPromotionsUseCase>(() => GetPromotionsUseCase(sl()));
}
