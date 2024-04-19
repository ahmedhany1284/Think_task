import 'package:flutter/material.dart';
import 'package:think_task/core/colors/app_colors.dart';

class NotificationsHistoryDialog extends StatelessWidget {
  final Map<String, dynamic> result;

  const NotificationsHistoryDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(primary: Colors.blue),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: AlertDialog(
        title: const Text('Results'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: result.entries
                .map((entry) => ListTile(
              title: Text(' ${entry.key}'),
              subtitle: Align(
                alignment: Alignment.centerRight,
                child: Text('-> ${entry.value.toString()}',style: TextStyle(
                color: AppColors.subtitle,
                ),),
              ),
            ))
                .toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
