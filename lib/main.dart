import 'package:avaliacao1dm3/config/dependencies.dart';
import 'package:avaliacao1dm3/routing/routing.dart';
import 'package:avaliacao1dm3/ui/core/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: localProviders, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      routerConfig: AppRouter.router,
    );
  }
}
