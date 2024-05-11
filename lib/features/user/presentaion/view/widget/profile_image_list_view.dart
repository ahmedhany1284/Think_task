import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_task/features/user/presentaion/view-model/user_cubit.dart';

class ProfileResultsView extends StatelessWidget {
  final Map<String, dynamic> result;

  const ProfileResultsView({super.key, required this.result});

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
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<UserCubit>()
                            .deleteProfileImage(entry.key)
                            .then((value) =>
                                context.read<UserCubit>().getProfileHistory());
                      },
                      icon: Icon(Icons.delete),
                    ),
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
