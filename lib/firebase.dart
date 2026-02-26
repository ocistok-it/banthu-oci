import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'firebase_options_prod.dart' as prod;
import 'firebase_options_dev.dart' as dev;

Future<void> initializeFirebaseApp() async {
  // Determine which Firebase options to use based on the flavor
  final firebaseOptions = switch (appFlavor) {
    'production' => prod.DefaultFirebaseOptions.currentPlatform,
    'development' => dev.DefaultFirebaseOptions.currentPlatform,
    _ => throw UnsupportedError('Invalid flavor: $appFlavor'),
  };
  await Firebase.initializeApp(options: firebaseOptions);
}
