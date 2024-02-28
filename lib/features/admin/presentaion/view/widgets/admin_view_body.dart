import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_task/core/presentaion/widgets/form_field_input.dart';
import 'package:think_task/features/admin/presentaion/view-model/admin_cubit.dart';
import 'package:think_task/features/admin/presentaion/view/widgets/admin_list_view.dart';

class AdminViewBody extends StatelessWidget {
  AdminViewBody({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocBuilder<AdminCubit, AdminStates>(
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 100),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const AdminListView(),
                    const SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print(controller.text);
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
