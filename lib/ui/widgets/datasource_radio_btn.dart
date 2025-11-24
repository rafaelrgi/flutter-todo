import 'package:flutter/material.dart';
import 'package:todo/core/config/config.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:todo/ui/widgets/radio_btn.dart';

class DataSourceRadioBtn extends RadioBtn {
  const DataSourceRadioBtn({
    super.key,
    required super.dataSource,
    required super.selected,
    required super.onPressed,
  });

  factory DataSourceRadioBtn.fromDataSource(
    BuildContext context,
    DataSources ds,
  ) {
    final todoViewModel = TodoViewModel.instance;
    final navigator = Navigator.of(context);

    final selected = (ds == todoViewModel.dataSource);
    return DataSourceRadioBtn(
      dataSource: ds,
      selected: selected,
      onPressed: () async {
        await todoViewModel.setDataSource(ds);
        if (!context.mounted) return;
        //returns true only when change the ds
        navigator.pop(!selected);
      },
    );
  }
}
