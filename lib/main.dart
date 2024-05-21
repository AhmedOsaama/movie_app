import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/core/utils/hive_helper.dart';

import 'core/app/app.dart';
import 'core/utils/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.moviesBox);
  await Hive.openBox<String>(HiveHelper.movieDetailBox);
  setupServiceLocator();
  runApp(const MyApp());
}

