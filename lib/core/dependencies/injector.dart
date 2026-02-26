import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constants/app_constants.dart';
import '../../features/authentication/authentication.dart';
import '../../features/categories/categories.dart';
import '../../features/notification/notification.dart';
import '../../features/product_detail/product_detail.dart';
import '../../features/sign_in/sign_in.dart';
import '../networks/networks.dart';

final sl = GetIt.instance;

Future<void> setupAuthenticationDependencies() async {
  /// Cubits / Blocs
  sl.registerLazySingleton<AuthenticationCubit>(
    () => AuthenticationCubit(tokenManager: sl<TokenManager>()),
  );

  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      notificationRemoteDataSource: sl<NotificationRemoteDataSource>(),
      tokenManager: sl<TokenManager>(),
    ),
  );
  sl.registerLazySingleton<NotificationUsecase>(
    () => NotificationUsecase(
      notificationRepository: sl<NotificationRepository>(),
    ),
  );
  sl.registerLazySingleton<NotificationCounterBloc>(
    () => NotificationCounterBloc(usecase: sl<NotificationUsecase>()),
  );
  ////
}

Future<void> setupDependencies() async {
  /// Repositories
  sl.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<ProductDetailRemoteDataSource>(
    () => ProductDetailRemoteDataSource(sl<Dio>()),
  );
  ////

  /// Repositories
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(signInDataSource: sl<SignInRemoteDataSource>()),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      categoriesRemoteDataSource: sl<CategoriesRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<ProductDetailRepository>(
    () => ProductDetailRepositoryImpl(
      productDetailRemoteDataSource: sl<ProductDetailRemoteDataSource>(),
    ),
  );
  ////

  /// Usecases
  sl.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(signInRepository: sl<SignInRepository>()),
  );
  sl.registerLazySingleton<CategoriesUsecase>(
    () => CategoriesUsecase(categoriesRepository: sl<CategoriesRepository>()),
  );
  sl.registerLazySingleton<ProductDetailUsecase>(
    () => ProductDetailUsecase(repository: sl<ProductDetailRepository>()),
  );
  ////
}

Future<void> setupNetworkDependencies({required String langcode}) async {
  /// Shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  ////

  /// Secure storage
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());
  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  ////

  /// Network Connectivity Checker
  sl.registerLazySingleton<NetworkConnectivity>(
    () => NetworkConnectivityImpl(),
  );
  ////

  /// Token Manager
  sl.registerLazySingleton<TokenManager>(
    () => TokenManagerImpl(sl<FlutterSecureStorage>()),
  );
  ////

  /// Cache Manager
  sl.registerLazySingleton<CacheManager>(
    () => CacheManagerImpl(sl<SharedPreferences>()),
  );
  ////

  /// App Dio
  sl.registerLazySingleton<AppDio>(
    () => AppDio(
      langcode: langcode,
      baseUrl: AppConstants.baseUrl,
      tokenManager: sl<TokenManager>(),
      cacheManager: sl<CacheManager>(),
      connectivity: sl<NetworkConnectivity>(),
    ),
  );
  sl.registerLazySingleton<Dio>(() => sl<AppDio>().dio);
  ////
}
