/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

NotificationSendModel notificationSendModelFromJson(String str) => NotificationSendModel.fromJson(json.decode(str));

String notificationSendModelToJson(NotificationSendModel data) => json.encode(data.toJson());

class NotificationSendModel {
    NotificationSendModel({
        required this.notification,
        this.data ,
        this.android,
        required this.to,
    });

    NotificationSendModelNotification notification;
    Data? data;
    Android? android;
    String to;

    factory NotificationSendModel.fromJson(Map<dynamic, dynamic> json) => NotificationSendModel(
        notification: NotificationSendModelNotification.fromJson(json["notification"]),
        data: json["data"]!=null ?Data.fromJson(json["data"]):Data(
            type: 'order',
            id: '123',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
        ),
        android:json["android"]!=null? Android.fromJson(json["android"]):Android(
        notification: AndroidNotification(
        defaultLightSettings: true,
        defaultVibrateTimings: true,
        defaultSound: true,
        sound: "default",
        notificationPriority: "PRIORITY_MAX",
    ),
    priority: "HIGH",
    ),
        to: json["to"],
    );

    Map<dynamic, dynamic> toJson() => {
        "notification": notification.toJson(),
        "data": data!.toJson(),
        "android": android!.toJson(),
        "to": to,
    };
}

class Android {
    Android({
        required this.notification,
        required this.priority,
    });

    AndroidNotification notification;
    String priority;

    factory Android.fromJson(Map<dynamic, dynamic> json) => Android(
        notification: AndroidNotification.fromJson(json["notification"]),
        priority: json["priority"],
    );

    Map<dynamic, dynamic> toJson() => {
        "notification": notification.toJson(),
        "priority": priority,
    };
}

class AndroidNotification {
    AndroidNotification({
        required this.defaultLightSettings,
        required this.defaultVibrateTimings,
        required this.defaultSound,
        required this.sound,
        required this.notificationPriority,
    });

    bool defaultLightSettings;
    bool defaultVibrateTimings;
    bool defaultSound;
    String sound;
    String notificationPriority;

    factory AndroidNotification.fromJson(Map<dynamic, dynamic> json) => AndroidNotification(
        defaultLightSettings: json["default_light_settings"],
        defaultVibrateTimings: json["default_vibrate_timings"],
        defaultSound: json["default_sound"],
        sound: json["sound"],
        notificationPriority: json["notification_priority"],
    );

    Map<dynamic, dynamic> toJson() => {
        "default_light_settings": defaultLightSettings,
        "default_vibrate_timings": defaultVibrateTimings,
        "default_sound": defaultSound,
        "sound": sound,
        "notification_priority": notificationPriority,
    };
}

class Data {
    Data({
        required this.id,
        required this.type,
        required this.clickAction,
    });

    String id;
    String type;
    String clickAction;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        clickAction: json["click_action"],
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "type": type,
        "click_action": clickAction,
    };
}

class NotificationSendModelNotification {
    NotificationSendModelNotification({
        required this.sound,
        required this.title,
        required this.body,
    });

    String sound;
    String title;
    String body;

    factory NotificationSendModelNotification.fromJson(Map<dynamic, dynamic> json) => NotificationSendModelNotification(
        sound: json["sound"],
        title: json["title"],
        body: json["body"],
    );

    Map<dynamic, dynamic> toJson() => {
        "sound": sound,
        "title": title,
        "body": body,
    };
}
