import 'package:todo/core/app/app_controller.dart';
import 'package:todo/core/config/config.dart';
import 'package:todo/core/utils/ui_utils.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/pages/choose_datasource.dart';
import 'package:todo/ui/pages/todo_view.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/loading_error.dart';
import 'package:todo/ui/widgets/todo_leading.dart';
import 'package:todo/ui/widgets/todo_list.dart';
import 'package:todo/ui/widgets/todo_list_floating_buttons.dart';

class TodosView extends StatelessWidget {
  //
  static const String _title = 'ToDo List';
  TodoViewModel get todoViewModel => TodoViewModel.instance;

  const TodosView({super.key});

  void _itemDialog(BuildContext context, [int index = -1]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(child: TodoView(index: index));
      },
    );
  }

  Future<void> _onItemTap(BuildContext context, int index) async {
    if (todoViewModel.dataSource != .localDb) {
      UiUtils.toast(
        context,
        '${todoViewModel.dataSource.text}: changes will NOT be persisted!',
      );
      return;
    }

    var error = await todoViewModel.checkAndSaveItem(index);
    if (!context.mounted) return;

    if (error.isNotEmpty) {
      UiUtils.alertDialog(context, error, 'Saving failed');
    }
  }

  void _loadData(BuildContext context) {
    (context as Element).markNeedsBuild();
  }

  Future<void> _changeDataSource(BuildContext context) async {
    if (!await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(child: ChooseDatasource());
      },
    )) {
      //cancel
      return;
    }

    if (!context.mounted) return;
    //ok
    if (todoViewModel.dataSource != .localDb) {
      await UiUtils.alertDialog(
        context,
        '${todoViewModel.dataSource.text}: changes will NOT be persisted! \r\n\r\nTo persist changes, choose LocalDB',
        'Warning',
      );
    }

    //linter is linting too much here....
    if (context.mounted) _loadData(context);
  }

  Future<void> _changeTheme(BuildContext context) async {
    final appController = AppController.instance;

    int i = (appController.themeMode.index + 1);
    if (i >= ThemeMode.values.length) {
      i = 0;
    }
    ThemeMode val = ThemeMode.values[i];
    await Config.setTheme(val);
    appController.themeMode = val;
    if (!context.mounted) return;
    UiUtils.toast(context, appController.themeMode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: todoViewModel.fetchAll(),
      builder: (_, AsyncSnapshot<List<Todo>> snapshot) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == .dark;

        //waiting
        if (snapshot.connectionState == .waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: TodoLeading(isDarkMode: isDarkMode),
              title: const Text(_title),
            ),
            body: Center(child: CircularProgressIndicator()),
          );

          //hasData
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: TodoLeading(isDarkMode: isDarkMode),
              title: const Text(_title),
              actions: [
                IconButton(
                  icon: Icon(todoViewModel.dataSource.iconData),
                  tooltip: 'Change data source',
                  onPressed: () => _changeDataSource(context),
                ),

                IconButton(
                  icon: const Icon(Icons.brightness_6_outlined),
                  tooltip: 'Change theme',
                  onPressed: () => _changeTheme(context),
                ),
              ],
            ),
            floatingActionButton: TodoListFloatingButtons(
              _itemDialog,
              (_) => _loadData(context), //must use THIS ctx
            ),

            body: TodoList(_itemDialog, _onItemTap),
          );

          //error
        } else {
          //if (snapshot.hasError)
          return Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: LoadingError(_loadData),
          );
        }
      },
    );
  }
}
