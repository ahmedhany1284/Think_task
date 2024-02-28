import 'package:flutter/material.dart';
import 'package:think_task/features/admin/presentaion/view/widgets/admin_view_body.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        body: AdminViewBody(),
        ),
    );
  }
}
