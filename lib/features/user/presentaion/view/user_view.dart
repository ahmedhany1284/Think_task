import 'package:flutter/material.dart';
import 'package:think_task/features/user/presentaion/view/widget/user_view_body.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserViewBody()
    );
  }
}
