import 'package:flutter/services.dart';

class AppConstants {
  AppConstants._();

  static String get baseUrl => switch (appFlavor) {
    "development" => "https://gateway-dev.banthu.com/",
    "production" => "https://gateway.banthu.com/",
    _ => "https://gateway-dev.banthu.com/",
  };

  static const double kDefaultPadding = 16.0;

  static const Duration cacheDuration = Duration(minutes: 5);
}

enum AppStatus { initial, loading, complete, failure }
