import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Constantes {
  String imagetest =
      "https://i.pinimg.com/564x/41/4c/74/414c7472d95b28f2d6673498c59cbfb3.jpg";
  String appName = "WAYIYAN";
  Color mainColor = Colors.blue;
  String applink = "https://halonexplore.page.link/telechargement";
  static String? fileLink;

  static bool recentConnect = false;
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "Prime_Club", "Prime_Club",
    description: "Prime_Club", playSound: true, importance: Importance.high);
