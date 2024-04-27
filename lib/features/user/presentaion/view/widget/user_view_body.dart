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
                     Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage('${context.read<UserCubit>().imageLink}'),
                          ),
                          Positioned(
                            bottom: 5.0,
                            right: 5.0,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Choose an option"),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context.read<UserCubit>().pickImageFromGallery();
                                                if(state is UploadImageToFirebaseStorageLoadingState){
                                                  const CircularProgressIndicator();
                                                }
                                                if(state is UploadImageToFirebaseStorageLoadedState){
                                                  context.pop();
                                                }
                                              },
                                              child: Text("Pick from gallery"),
                                            ),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<UserCubit>().pickImageFromCamera();
                                                if(state is UploadImageToFirebaseStorageLoadingState){
                                                  const CircularProgressIndicator();
                                                }
                                                if(state is UploadImageToFirebaseStorageLoadedState){
                                                  context.pop();
                                                }
                                              },
                                              child: Text("Use camera"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );


                              },
                              child: Icon(
                                Icons.camera,
                                color: Colors.black,
                                size: 28.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
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
                
                              await context.read<UserCubit>().submitData();
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
