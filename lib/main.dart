import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_task/constnts.dart';
import 'package:think_task/core/app_router.dart';
import 'package:think_task/features/admin/presentaion/view-model/admin_cubit.dart';
import 'package:think_task/features/user/presentaion/view-model/user_cubit.dart';
import 'package:think_task/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/models/notification_responce_model.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.toMap().toString()}");
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    message.notification?.title ?? '',
    message.notification?.body ?? '',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'Channel Name',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Constants.notificationToken= await FirebaseMessaging.instance.getToken();
  print(  Constants.notificationToken!);

  FirebaseMessaging.onMessage.listen((RemoteMessage message ) async{
    print('A new onMessage event was published!');
    if(message.notification!=null){
      Constants.notificationResponceModel=NotificationResponceModel.fromJson(message.toMap());
    }
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'Channel Name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('A new onMessageOpenedApp event was published!');


    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'Channel Name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminCubit()..getFileNames()),
        BlocProvider(create: (context) => UserCubit()..getFileNames()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
        ),
      ),
    );
  }
}
