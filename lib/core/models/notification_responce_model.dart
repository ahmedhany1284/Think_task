/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

NotificationResponceModel notificationResponceModelFromJson(String str) => NotificationResponceModel.fromJson(json.decode(str));

String notificationResponceModelToJson(NotificationResponceModel data) => json.encode(data.toJson());

class NotificationResponceModel {
    NotificationResponceModel({
        required this.data,
        required this.messageId,
        required this.mutableContent,
        required this.ttl,
        required this.notification,
        required this.collapseKey,
        required this.sentTime,
        required this.from,
        required this.contentAvailable,
    });

    Data data;
    String? messageId;
    bool? mutableContent;
    int? ttl;
    Notification notification;
    String? collapseKey;
    int sentTime;
    String? from;
    bool? contentAvailable;

    factory NotificationResponceModel.fromJson(Map<dynamic, dynamic> json) => NotificationResponceModel(
        data: Data.fromJson(json["data"]),
        messageId: json["messageId"],
        mutableContent: json["mutableContent"],
        ttl: json["ttl"],
        notification: Notification.fromJson(json["notification"]),
        collapseKey: json["collapseKey"],
        sentTime: json["sentTime"],
        from: json["from"],
        contentAvailable: json["contentAvailable"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "messageId": messageId,
        "mutableContent": mutableContent,
        "ttl": ttl,
        "notification": notification.toJson(),
        "collapseKey": collapseKey,
        "sentTime": sentTime,
        "from": from,
        "contentAvailable": contentAvailable,
    };
}

class Data {
    Data({
        required this.id,
        required this.type,
        required this.clickAction,
    });

    String? id;
    String? type;
    String? clickAction;

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

class Notification {
    Notification({
        required this.android,
        required this.bodyLocArgs,
        required this.titleLocArgs,
        required this.title,
        required this.body,
    });

    Android android;
    List<dynamic?> bodyLocArgs;
    List<dynamic?> titleLocArgs;
    String ?title;
    String ?body;

    factory Notification.fromJson(Map<dynamic, dynamic> json) => Notification(
        android: Android.fromJson(json["android"]),
        bodyLocArgs: List<dynamic>.from(json["bodyLocArgs"].map((x) => x)),
        titleLocArgs: List<dynamic>.from(json["titleLocArgs"].map((x) => x)),
        title: json["title"],
        body: json["body"],
    );

    Map<dynamic, dynamic> toJson() => {
        "android": android.toJson(),
        "bodyLocArgs": List<dynamic>.from(bodyLocArgs.map((x) => x)),
        "titleLocArgs": List<dynamic>.from(titleLocArgs.map((x) => x)),
        "title": title,
        "body": body,
    };
}

class Android {
    Android({
        required this.visibility,
        required this.sound,
        required this.priority,
    });

    int? visibility;
    String? sound;
    int? priority;

    factory Android.fromJson(Map<dynamic, dynamic> json) => Android(
        visibility: json["visibility"],
        sound: json["sound"],
        priority: json["priority"],
    );

    Map<dynamic, dynamic> toJson() => {
        "visibility": visibility,
        "sound": sound,
        "priority": priority,
    };
}
