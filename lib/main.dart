import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/academeet_app.dart';
import 'core/service/dependency_injection.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(ProviderScope(child: const AcadeMeetApp()));
}
