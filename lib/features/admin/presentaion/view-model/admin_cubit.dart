import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:think_task/constnts.dart';
import 'package:think_task/core/models/notification_responce_model.dart';

import '../../../../firebase_options.dart';

part 'admin_states.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  List<String> fieldNames = [];
  Map<String, dynamic> notificationHistory = {};

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> updateFileNames(String value) async {
    try {
      String index = (fieldNames.length + 1).toString();
      await FirebaseFirestore.instance
          .collection('fields')
          .doc('D99d0CV6gcIBMZkMSpnS')
          .update({index: value});
      emit(SendDataSuccessState(value));
    } catch (e) {
      print(e.toString());
      emit(SendDataFailedState());
    }
  }

  Future<void> getFileNames() async {
    try {
      FirebaseFirestore.instance
          .collection('fields')
          .doc('D99d0CV6gcIBMZkMSpnS')
          .snapshots()
          .listen((event) {
        List<String> updatedFilenames = [];
        var data = event.data();
        if (data != null) {
          var values = data.values.toList();
          updatedFilenames.addAll(values.map((e) => e.toString()));
        }
        fieldNames = updatedFilenames;
        sendNotification('The latest field added is ${fieldNames.last}');
        emit(GetDataSuccessState(fieldNames));
      });
    } catch (e) {
      print(e.toString());
      emit(GetDataFailedState());
    }
  }

  Future<void> sendNotification(String message) async {
    final String to = Constants.notificationToken!;
    final Map<String, dynamic> notification = {
      'title': 'Admin Panel Notification',
      'body': message,
      'sound': 'default',
    };

    final Map<String, dynamic> androidNotification = {
      'notification_priority': 'PRIORITY_MAX',
      'sound': 'default',
      'default_sound': true,
      'default_vibrate_timings': true,
      'default_light_settings': true,
    };

    final Map<String, dynamic> data = {
      'type': 'order',
      'id': '123',
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    };

    final Map<String, dynamic> body = {
      'notification': notification,
      'data': data,
      'android': {'priority': 'HIGH', 'notification': androidNotification},
      'to': to,
    };

    final String encodedBody = json.encode(body);

    final http.Response response = await http.post(
      Uri.parse(Constants.fcmApi),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Constants.serverKey}',
      },
      body: encodedBody,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      print('Notification sent successfully');
      await extractAndStoreMessages(Constants.notificationResponceModel!);
      await getNotificationHistory();
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }

  Future<void> extractAndStoreMessages(NotificationResponceModel message) async {
    try{
      print('got to extractAndStoreMessages');
      final sentTime = message.sentTime;
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(sentTime);
      final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

      // final CollectionReference collection = FirebaseFirestore.instance.collection('messages');
      // await collection.doc('Notifications').update({formattedDateTime: message.notification.body});

      final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('messages');

      await databaseReference.update({formattedDateTime: message.notification.body});

      print('Message extracted and stored successfully.');
    }catch (e){
      print('--> errorstoring the massage ${e.toString()}');
    }

  }



  Future<void> getNotificationHistory() async {
    try {
      print('got to getNotificationHistory');
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('messages').get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          notificationHistory[key.toString()] = value.toString();
        });

        var entries = notificationHistory.entries.toList();
        entries.sort((a, b) => a.key.compareTo(b.key));
        notificationHistory = Map.fromEntries(entries);

      } else {
        print('No data available.');
      }



      emit(GetNotificationsHistorySuccessState(notificationHistory));
    } catch (e) {
      print(e.toString());
      emit(GetNotificationsHistoryFailedState());
    }
  }



}
