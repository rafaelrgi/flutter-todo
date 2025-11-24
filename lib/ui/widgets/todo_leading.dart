import 'package:flutter/material.dart';

class TodoLeading extends StatelessWidget {
  //
  final bool isDarkMode;

  const TodoLeading({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Tooltip(
      message: 'Logout',
      child: TextButton(
        onPressed: () => navigator.pushReplacementNamed('/'),
        child: Hero(
          tag: 'icon',
          child: isDarkMode
              ? Image.asset('assets/icons/app_icon_p_dark.png')
              : Image.asset('assets/icons/app_icon_p.png'),
        ),
      ),
    );
  }
}
