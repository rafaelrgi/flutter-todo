import 'package:flutter/material.dart';
import 'package:todo/core/config/config.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:todo/ui/widgets/datasource_radio_btn.dart';

class ChooseDatasource extends StatelessWidget {
  //
  const ChooseDatasource({super.key});

  @override
  Widget build(BuildContext context) {
    final todoViewModel = TodoViewModel.instance;
    final navigator = Navigator.of(context);

    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (context, _) {
        return todoViewModel.isLoading
            //
            // Loading
            ? const Padding(
                padding: .all(64),
                child: Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: CircularProgressIndicator(),
                ),
              )
            //
            //Has data
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    Padding(
                      padding: const .symmetric(vertical: 8, horizontal: 16),
                      child: const Text('Choose the datasource:'),
                    ),
                    Divider(height: 8, thickness: 1, color: Colors.grey),
                    Padding(
                      padding: const .all(16.0),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .start,
                        children: [
                          DataSourceRadioBtn.fromDataSource(
                            context,
                            DataSources.memory,
                          ),
                          DataSourceRadioBtn.fromDataSource(
                            context,
                            DataSources.remoteApi,
                          ),
                          DataSourceRadioBtn.fromDataSource(
                            context,
                            DataSources.localDb,
                          ),
                          Divider(height: 8, thickness: 1, color: Colors.grey),
                          Align(
                            alignment: .centerRight,
                            child: TextButton(
                              onPressed: () => navigator.pop(false),
                              child: const Text('Cancel'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
