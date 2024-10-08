import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rudraksha_cart/pages/notifications/notifications_widget.dart';

class NotificationServices{

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void requestNotificationPermission()async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    } else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    } else{
      print('User denied permission');
    }
  }
  
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
      onDidReceiveNotificationResponse: (payload){
          handleMessage(context, message);
      }
    );
  }

  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message){

      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }

      initLocalNotifications(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message)async {

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notifications',
      importance: Importance.max
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker"
    );

    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );

    Future.delayed(
      Duration.zero, (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails
      );}
    );
  }

  void handleMessage(BuildContext context, RemoteMessage message){
    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
  }

  Future<String> getDeviceToken() async{
    String? token = await messaging.getToken();
    return token!;
  }
}