/*
import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app_state.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
  // Handle the background message and update state if needed
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final StreamController<RemoteMessage> _messageStreamController = StreamController.broadcast();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Stream<RemoteMessage> get messages => _messageStreamController.stream;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    FFAppState().firebaseToken = fCMToken!;
    print('Firebase Token: $fCMToken');
    print('Firebase Token ffappstate: ${FFAppState().firebaseToken}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground: ${message.messageId}');
      _messageStreamController.add(message);

      _logNotificationEvent(message); // Call _logNotificationEvent with each message
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void _logNotificationEvent(RemoteMessage message) {
    _analytics.logEvent(
      name: 'notification_received',
      parameters: {
        'title': message.notification?.title,
        'body': message.notification?.body,
        'data': message.data,
      },
    );
  }

  void dispose() {
    _messageStreamController.close();
  }
}

*/


import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app_state.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
  // Handle the background message and update state if needed
}

class FirebaseApi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final StreamController<RemoteMessage> _messageStreamController = StreamController.broadcast();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Stream<RemoteMessage> get messages => _messageStreamController.stream;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    FFAppState().firebaseToken = fCMToken!;
    print('Firebase Token: $fCMToken');
    print('Firebase Token ffappstate: ${FFAppState().firebaseToken}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground: ${message.messageId}');
      _messageStreamController.add(message);

      _logNotificationEvent(message); // Call _logNotificationEvent with each message
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void _logNotificationEvent(RemoteMessage message) {
    _analytics.logEvent(
      name: 'notification_received',
      parameters: {
        'title': message.notification?.title,
        'body': message.notification?.body,
        'data': message.data,
      },
    );
  }

  void dispose() {
    _messageStreamController.close();
  }
}

