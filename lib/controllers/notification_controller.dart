import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  static void initialize() {
    FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: true, sound: true, criticalAlert: true);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  playSound: true,
                  color: Colors.blue,
                  icon: "@mipmap/ic_launcher")));
    });
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  Stream<List<Map<String, dynamic>>> userNofif(String uid, bool? isIn) {
    return db
        .collection('users')
        .doc(uid)
        .collection("notifs")
        .orderBy("creation", descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        if (isIn == true) {
          if (e.data()['isview'] == false) {
            db
                .collection('users')
                .doc(uid)
                .collection("notifs")
                .doc(e.id)
                .update({'isview': true});
          }
        }
        return e.data();
      }).toList();
    });
  }
}
