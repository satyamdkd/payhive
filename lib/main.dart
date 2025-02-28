import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payhive/app.dart';
import 'package:payhive/services/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const PayHive());
}

initialize() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setUpDi();
}

