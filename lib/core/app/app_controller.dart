import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/config/config.dart';

class AppController extends ChangeNotifier {
  //
  static AppController get instance => GetIt.instance<AppController>();

  ThemeMode _type = ThemeMode.system;

  ThemeMode get themeMode => _type;

  AppController() {
    _init();
  }

  void _init() async {
    themeMode = await Config.getTheme();
  }

  set themeMode(ThemeMode val) {
    _type = val;
    notifyListeners();
  }
}
