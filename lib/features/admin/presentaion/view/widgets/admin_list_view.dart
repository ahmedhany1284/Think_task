import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_task/core/presentaion/widgets/form_field_input.dart';
import 'package:think_task/features/admin/presentaion/view-model/admin_cubit.dart';

class AdminListView extends StatelessWidget {
  const AdminListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocBuilder<AdminCubit, AdminStates>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return CustomInputField(
              controller: controller,
              type: TextInputType.text,
              label: 'Field  gg',
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20.0);
          },
        );
      },
    );
  }
}
