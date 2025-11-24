import 'package:flutter/material.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';

class TodoList extends StatelessWidget {
  //
  final void Function(BuildContext, int) itemDialog;
  final void Function(BuildContext, int) itemTap;
  TodoViewModel get todoViewModel => TodoViewModel.instance;

  const TodoList(this.itemDialog, this.itemTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (_, _) {
        return ListView.builder(
          padding: const .fromLTRB(8, 8, 8, 160),
          itemCount: todoViewModel.todos.length,
          itemBuilder: (_, index) {
            final todo = todoViewModel.todos[index];
            return ListTile(
              onTap: () => itemTap(context, index),
              title: Text(todo.title),
              leading: Icon(
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              trailing: IconButton(
                onPressed: () => itemDialog(context, index),
                icon: const Icon(Icons.open_in_new),
                tooltip: 'View details about this item',
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1),
                borderRadius: .circular(5),
              ),
            );
          },
        );
      },
    );
  }
}
