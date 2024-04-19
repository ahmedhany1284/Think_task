import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:think_task/core/app_router.dart';
import 'package:think_task/core/colors/app_colors.dart';
import 'package:think_task/core/presentaion/widgets/form_field_input.dart';
import 'package:think_task/features/admin/presentaion/view-model/admin_cubit.dart';
import 'package:think_task/features/admin/presentaion/view/widgets/admin_list_view.dart';
import 'package:think_task/features/admin/presentaion/view/widgets/custom_alert_widget.dart';
import 'package:think_task/features/admin/presentaion/view/widgets/norification_history_dialog.dart';

import '../../../../user/presentaion/view/widget/results.dart';

class AdminViewBody extends StatelessWidget {
  AdminViewBody({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocBuilder<AdminCubit, AdminStates>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Admin View'),
              backgroundColor: AppColors.appBar,
              elevation: 1.2,
              actions: [
                IconButton(
                  onPressed: () async{
                    await context.read<AdminCubit>().getNotificationHistory();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {

                        print(context.read<AdminCubit>().notificationHistory );
                        return NotificationsHistoryDialog(
                          result: context.read<AdminCubit>().notificationHistory,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.notifications),
                ),
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 100),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AdminListView(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: 100,
                          color: AppColors.primary,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertWidget(
                                    controller: controller,
                                    formKey: formKey,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
