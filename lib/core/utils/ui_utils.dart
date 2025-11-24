import 'package:flutter/material.dart';

class UiUtils {
  //
  static void toast(
    BuildContext context,
    String text, [
    bool clearPending = true,
  ]) {
    final messenger = ScaffoldMessenger.of(context);
    if (clearPending) {
      messenger.clearSnackBars();
    }
    messenger.showSnackBar(
      SnackBar(content: Text(text)), //duration: Durations.extralong3
    );
  }

  static Future<void> errorDialog(
    BuildContext context,
    String message,
    String title,
  ) {
    final navigator = Navigator.of(context);

    return showDialog(
      context: context,
      barrierColor: Colors.black, //.withValues(alpha: 0.9),
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const .symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: .min,
              children: [
                Text(title),
                Divider(height: 16, thickness: 1, color: Colors.grey),
                const SizedBox(height: 16),
                Text(message),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => navigator.pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> alertDialog(
    BuildContext context,
    String message,
    String title,
  ) {
    final navigator = Navigator.of(context);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const .symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: .min,
              children: [
                Text(title),
                Divider(height: 16, thickness: 1, color: Colors.grey),
                const SizedBox(height: 16),
                Text(message),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => navigator.pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void yesNoDialog(
    BuildContext context,
    String message,
    String title,
    VoidCallback? onConfirm,
  ) {
    final navigator = Navigator.of(context);

    Widget yesButton = TextButton(onPressed: onConfirm, child: Text("Yes"));
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () => navigator.pop(),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [noButton, yesButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
