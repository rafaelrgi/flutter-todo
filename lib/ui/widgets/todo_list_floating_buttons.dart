import 'package:flutter/material.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';

class TodoListFloatingButtons extends StatelessWidget {
  //
  final void Function(BuildContext) itemDialog;
  final void Function(BuildContext) loadData;
  TodoViewModel get todoViewModel => TodoViewModel.instance;

  const TodoListFloatingButtons(this.itemDialog, this.loadData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .end,
      mainAxisAlignment: .end,
      children: <Widget>[
        if (todoViewModel.dataSource == .localDb)
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () => itemDialog(context),
            tooltip: 'Add Todo',
            child: const Icon(Icons.add),
          ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () => loadData(context),
          tooltip: 'Refresh the list',
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
