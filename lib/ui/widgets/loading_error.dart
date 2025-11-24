import 'package:flutter/material.dart';

class LoadingError extends StatelessWidget {
  //
  final void Function(BuildContext) loadData;

  const LoadingError(this.loadData, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 64),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          Text(
            'Failed to load data',
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
          ),
          Divider(height: 16, thickness: 1, color: Colors.grey),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => loadData(context),
            child: const Text('Retry!'),
          ),
        ],
      ),
    );
  }
}
