import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'app/design_system/design_system.dart';
import 'banthu_app.dart';
import 'core/dependencies/injector.dart';
import 'firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await initializeFirebaseApp();

  await setupNetworkDependencies(langcode: "en");

  await setupAuthenticationDependencies();

  final banthuApp = await ThemeScopeWidget.initialize(
    EasyLocalization(
      supportedLocales: [const Locale("th", "TH"), const Locale("en", "TH")],
      path: "assets/translations",
      fallbackLocale: const Locale("en", "TH"),
      child: const BanthuApp(),
    ),
  );

  runApp(banthuApp);
}
