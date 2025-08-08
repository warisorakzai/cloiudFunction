import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cloudfunction/screens/home_screen/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationService with ChangeNotifier {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotification() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      providesAppNotificationSettings: true,
      criticalAlert: true,
      sound: true,
      provisional: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user permission grantes');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user permission granted provisonal');
      Get.snackbar(
        'Permission Denied',
        'User did not grant notification permission',
        snackPosition: SnackPosition.BOTTOM,
      );
      Future.delayed(Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
      notifyListeners();
    }
  }

  Future<String> getDeviceToken(BuildContext  context) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      providesAppNotificationSettings: true,
      criticalAlert: true,
      sound: true,
      provisional: true,
    );

    // String? token = await firebaseMessaging.getToken();
    String token = await Provider.of<NotificationService>(context, listen: false).getDeviceToken(context);
// Store `token` in your Firestore under user's document

    print('token==$token');
    return token!;
  }

  // void initLocalNotification(
  //   BuildContext context,
  //   RemoteMessage message,
  // ) async {
  //   var andriodInitSetting = AndroidInitializationSettings(
  //     '@mipmap/ic_launcher',
  //   );

  //   var initializationSettings = InitializationSettings(
  //     android: andriodInitSetting,
  //   );

  //   await _flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveBackgroundNotificationResponse: (payload) {
  //       handleMessage(context, message);
  //     },
  //   );
  // }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
  var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInit = DarwinInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: androidInit,
    iOS: iosInit,
  );

  await _flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      handleMessage(context, message);
    },
  );
}


  Future<void> handleMessage(
    BuildContext context,
    RemoteMessage message,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),

      importance: Importance.high,
      showBadge: true,
      playSound: true,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: 'Channel Description',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: channel.sound,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }
   Future<void> setUpInteractMessage(BuildContext context) async {
      // background State
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        handleMessage(context, message);
      });
      // Terminated State

      FirebaseMessaging.instance.getInitialMessage().then((
        RemoteMessage? message,
      ) {
        if (message != null && message.data.isNotEmpty) {
          handleMessage(context, message);
        }
      });
    }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;

      if (kDebugMode) {
        print('Notification title${notification!.title}');
        print('Notification title${notification.body}');

        if (Platform.isAndroid) {
          initLocalNotification(context, message);
          // handleMessage(context, message);
          showNotification(message);
        }
      }
    });

 
  }
    
}
