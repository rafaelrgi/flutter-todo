import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/app/app_controller.dart';
import 'package:todo/ui/app_theme.dart';
import 'package:todo/ui/pages/login_view.dart';
import 'package:todo/ui/pages/todos_view.dart';
import 'package:todo/ui/view_models/login_view_model.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';

class TodoApp extends StatelessWidget {
  //
  const TodoApp({super.key});

  static void configureDependencies() {
    final getIt = GetIt.instance;
    getIt.registerCachedFactory(() => LoginViewModel());
    getIt.registerLazySingleton<TodoViewModel>(() => TodoViewModel());
    getIt.registerLazySingleton<AppController>(() => AppController());
  }

  @override
  Widget build(BuildContext context) {
    final appController = AppController.instance;

    return ListenableBuilder(
      listenable: appController,
      builder: (context, _) {
        return MaterialApp(
          title: 'ToDo',
          debugShowCheckedModeBanner: false,
          //Theme
          themeMode: appController.themeMode,
          theme: AppTheme.buildTheme(false),
          darkTheme: AppTheme.buildTheme(true),
          //Routes
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginView(),
            '/home': (context) => const TodosView(),
            '/todos': (context) => const TodosView(),
          },
        );
      },
    );
  }
}
