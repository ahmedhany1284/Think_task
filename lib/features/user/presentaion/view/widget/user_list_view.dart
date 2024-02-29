import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_task/core/presentaion/widgets/form_field_input.dart';
import 'package:think_task/features/user/presentaion/view-model/user_cubit.dart';


class UserListView extends StatelessWidget {
  UserListView({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().initControllers();
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: BlocProvider.of<UserCubit>(context).fieldKeys.length,
          itemBuilder: (context, index) {
            return CustomInputField(
              controller: context.read<UserCubit>().controllers[index] ,
              type: TextInputType.text,
              label: context.read<UserCubit>().fieldKeys[index],
              onChange: (value) {
                context.read<UserCubit>().updateControllerValue(index, value);
              }
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
