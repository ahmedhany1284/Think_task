import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultsView({super.key, required this.result});

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
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: result.entries
              .map((entry) => ListTile(
            title: Text(entry.key),
            subtitle: Text(entry.value.toString()),
          ))
              .toList(),
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
