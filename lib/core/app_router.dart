import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:think_task/core/presentaion/home.dart';
import 'package:think_task/features/admin/presentaion/view/admin-vew.dart';
import 'package:think_task/features/user/presentaion/view/user_view.dart';

abstract class AppRouter {
  static const kadminView = '/';
  static const kUserView = '/userView';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: kadminView,
        builder: (BuildContext context, GoRouterState state) =>
            const MainScreen(),
      ),GoRoute(
        path: kadminView,
        builder: (BuildContext context, GoRouterState state) =>
            const AdminView(),
      ),
      GoRoute(
        path: kUserView,
        builder: (BuildContext context, GoRouterState state) =>
            const UserView(),
      ),
    ],
  );
}
