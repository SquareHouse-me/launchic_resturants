import 'dart:developer';
import 'dart:io';
import 'dart:math'as m;
 
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async {
 
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        log('user granted permission');
      }
        await Permission.notification.request();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        log('user granted provisional permission');
      }  await Permission.notification.request();
    } else { openAppSettings();
      if (kDebugMode) {
        log('user denied permission');
      }
    } 
  }
  
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    log('$token getDeviceToken');

    // Save the token and the current timestamp
    var box = Hive.box('userBox');
    box.put('DeviceToken', token);
    box.put('TokenTimestamp', DateTime.now().millisecondsSinceEpoch);

    return token!;
  }

  Future<String> isTokenRefresh() async {
    String newToken = '';
    messaging.onTokenRefresh.listen((event) async {
      newToken = event;
      var box = Hive.box('userBox');
      box.put('DeviceToken', newToken);
      box.put('TokenTimestamp', DateTime.now().millisecondsSinceEpoch);
      log('Token refreshed: $newToken');
    }).asFuture(); // Be careful with this, it might not work as expected if onTokenRefresh doesn't emit immediately

    // Return the new or existing token
    newToken = await Hive.box('userBox').get('DeviceToken').toString();
    return newToken;
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((messages) {
      print(messages.notification!.title.toString());
      if (Platform.isIOS) {
        foregroundMessage();
      }
      if (Platform.isAndroid) {
        initNotification(context: context, message: messages);
        showNotification(messages);
      }
    });
  }

  Future<void> initNotification(
      {required BuildContext context, required RemoteMessage message}) async {
    //AndroidInitializationSettings
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/background');

//initializationSettingsIOS
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await  localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      handleMessage(context, message);
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    
    int id=m.Random.secure().nextInt(10000000);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'HighImportanceNotification',
             "HighImportanceNotification name",
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            // sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            //  icon: largeIconPath
            );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true,
            );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails,);

     
      await localNotificationsPlugin.show(
      id ,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
     
  }

//handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background but app is open
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {

     
    String title=message.notification!.title.toString();
     String description=message.notification!.body.toString();
     log(title+description);
  }

 Future foregroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
