import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:think_task/core/colors/app_colors.dart';
import 'package:think_task/core/presentaion/widgets/form_field_input.dart';
import 'package:think_task/features/admin/presentaion/view-model/admin_cubit.dart';

class CustomAlertWidget extends StatelessWidget {
  const CustomAlertWidget({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.light(primary: AppColors.primary),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: AlertDialog(
        title: const Text('Add New Task'),
        content: CustomInputField(
          controller: controller,
          label: 'Write the field name', type: TextInputType.text,
      
        ),
        actions: [
          TextButton(
            onPressed: () async{
              if (formKey.currentState!.validate()) {
                await context
                    .read<AdminCubit>()
                    .updateFileNames( controller.text,);
                controller.clear();
              }
              context.pop();
            },
            child: const Text('Add'),
          ),

        ],
      ),
    );
  }
}