/*
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'notifications_widget.dart' show NotificationsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationsModel extends FlutterFlowModel<NotificationsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsModel extends ChangeNotifier {
  final List<RemoteMessage> _notifications = [];

  List<RemoteMessage> get notifications => _notifications;

  void addNotification(RemoteMessage message) {
    _notifications.add(message);
    notifyListeners();
  }

  void dispose() {
    _notifications.clear();
    super.dispose();
  }
}

class NotificationProvider extends ChangeNotifier {
  List<RemoteMessage> _notifications = [];

  List<RemoteMessage> get notifications => _notifications;

  void addNotification(RemoteMessage message) {
    _notifications.add(message);
    notifyListeners();
  }

  void removeNotification(RemoteMessage message) {
    _notifications.remove(message);
    notifyListeners();
  }
}

