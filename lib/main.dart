import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/bloc/main_screen_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/presentation/main_screen.dart';
import 'package:recent_dishes_app/src/features/main_screen/repository/main_screen_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recent_dishes_app/src/utils/router.dart';
import '../../../../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appRouter = AppRouter();
  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
        title: 'Recent',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
  }
}
