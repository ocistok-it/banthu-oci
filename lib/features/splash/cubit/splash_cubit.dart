import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/dependencies/injector.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import '../../notification/notification_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required AuthenticationCubit authenticationCubit})
    : _authenticationCubit = authenticationCubit,
      super(SplashInitial());

  final AuthenticationCubit _authenticationCubit;

  Future<void> initializeApp() async {
    emit(const SplashLoading());
    await Future.delayed(Duration(seconds: 3), () async {
      await setupDependencies();

      /// clean everything if hasRunBefore = true;
      await clearSecureStorageOnReinstall();

      await _authenticationCubit.checkAuthentication();

      await NotificationService.instance.initialize();
    });
  }

  Future<void> clearSecureStorageOnReinstall() async {
    const String key = 'hasRunBefore';
    SharedPreferences sharedPreferences = sl<SharedPreferences>();

    final bool? hasRunBefore = sharedPreferences.getBool(key);
    print("hasRunBefore $hasRunBefore");
    if (hasRunBefore == null) {
      print(
        "hasRunBefore is null, trying to delete all data and set the value to true",
      );
      FlutterSecureStorage secureStorage = sl<FlutterSecureStorage>();
      await secureStorage.deleteAll();
      await sharedPreferences.setBool(key, true);
      print("data cleared! hasRunBefore set to true");
      return;
    }
    print("hasRunBefore is $hasRunBefore, skipping the check and continue");
  }
}
