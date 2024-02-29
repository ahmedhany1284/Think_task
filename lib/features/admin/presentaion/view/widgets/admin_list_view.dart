import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_task/core/presentaion/widgets/form_field_input.dart';
import 'package:think_task/features/admin/presentaion/view-model/admin_cubit.dart';

class AdminListView extends StatelessWidget {
   AdminListView({
    super.key,
  });
  List<TextEditingController> controllers = [];
  @override
  Widget build(BuildContext context) {


    if (controllers.isEmpty) {
      controllers = List.generate(
        BlocProvider.of<AdminCubit>(context).fieldNames.length,
            (index) => TextEditingController(),
      );
    }

    return BlocBuilder<AdminCubit, AdminStates>(
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: BlocProvider.of<AdminCubit>(context).fieldNames.length,
          itemBuilder: (context, index) {
            return CustomInputField(
              controller: controllers[index],
              type: TextInputType.text,
              label: context.read<AdminCubit>().fieldNames[index],
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
