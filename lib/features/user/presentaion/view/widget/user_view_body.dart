import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:think_task/core/app_router.dart';
import 'package:think_task/core/colors/app_colors.dart';
import 'package:think_task/features/user/presentaion/view-model/user_cubit.dart';
import 'package:think_task/features/user/presentaion/view/widget/results.dart';
import 'package:think_task/features/user/presentaion/view/widget/user_list_view.dart';

class UserViewBody extends StatelessWidget {
  const UserViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        return state is SendDataLoadingState?const CircularProgressIndicator():Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 100.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserListView(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 100,
                        color: AppColors.primary,
                        child: TextButton(
                          onPressed: ()async {
                             context.read<UserCubit>().putInValues();
                             context.read<UserCubit>().combineToMap();
                
                              await context.read<UserCubit>().submitDtate();
                              final result = context.read<UserCubit>().data;
                             showDialog(
                               context: context,
                               builder: (BuildContext context) {
                                 return ResultsView(result: result);
                               },
                             );
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
