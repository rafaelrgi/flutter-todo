import 'package:flutter/material.dart';
import 'package:todo/core/config/config.dart';

class RadioBtn extends StatelessWidget {
  //
  final DataSources dataSource;
  final void Function() onPressed;
  final bool selected;

  const RadioBtn({
    super.key,
    required this.dataSource,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = (Theme.of(context).textTheme);
    final Color color = (textTheme.bodySmall!.color)!;

    final IconData radioIco = selected
        ? Icons.radio_button_checked
        : Icons.radio_button_off_outlined;

    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(radioIco, color: color),
          Text('   ${dataSource.text}', style: textTheme.bodyMedium),
          const SizedBox(width: 16),
          Icon(dataSource.iconData, color: color),
        ],
      ),
    );
  }
}
