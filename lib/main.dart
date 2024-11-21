import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'auth/custom_auth/auth_util.dart';
import 'auth/custom_auth/custom_auth_user_provider.dart';
import 'firebase_options.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'pages/notifications/notifications_widget.dart';
 
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
 
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
 
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message);
}
 
void _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('default_channel_id', 'Default Channel',
          importance: Importance.max, priority: Priority.high, showWhen: true);
 
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails();
 
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
 
  // Save the notification details in FFAppState
  FFAppState().addNotification(NotificationItem(
    message.notification?.title ?? 'No Title',
    message.notification?.body ?? 'No Body',
    DateTime.now(),
  ));
 
  // Show the notification
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: message.data['route'],
  );
 
  // Navigate to a specific screen if the app is in the foreground
  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (context) => NotificationScreen()),
  );
}
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 
  // Initialize FFAppState
  final appState = FFAppState();
  await appState.initializePersistedState();
 
  // Initialize authentication
  await authManager.initialize();
 
  // Request FCM token and monitor token changes
  String? token = await FirebaseMessaging.instance.getToken();
  if (token != null) FFAppState().firebaseToken = token;
 
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    FFAppState().firebaseToken = newToken;
  });
 
  print("FCM Token: ${FFAppState().firebaseToken}");
 
  // Handle notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });
 
  // Local notifications initialization
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
 
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );
 
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
 
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (response) {
    if (response.payload != null) {
      navigatorKey.currentState?.pushNamed(response.payload!);
    }
  });
 
  // Request notification permissions
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    criticalAlert: true,
    provisional: true,
  );
 
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
 
  // Run the app
  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}
 
// Callback for iOS notifications received in the foreground
@pragma('vm:entry-point')
void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  showDialog(
    context: navigatorKey.currentState!.context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title ?? 'Notification'),
      content: Text(body ?? ''),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    ),
  );
}
 
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
 
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}
 
class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
 
  late Stream<RudrakshaCartAuthUser> userStream;
  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
 
  @override
  void initState() {
    super.initState();
 
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = rudrakshaCartAuthUserStream()
      ..listen((user) => _appStateNotifier.update(user));
 
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }
 
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rudraksha-Ratna',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
     
    );
  }
}