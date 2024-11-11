import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:rudraksha_cart/pages/notifications/notifications_widget.dart';
import 'auth/custom_auth/auth_util.dart';
import 'auth/custom_auth/custom_auth_user_provider.dart';
import 'firebase_options.dart';
import 'flutter_flow/flutter_flow_util.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  _showNotification(
      message); // Firebase initialization is only needed once in main()
}

void _showNotification(RemoteMessage message) async {
  // Android notification settings
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Store notification in FFAppState (ensure addNotification is implemented)
  FFAppState().addNotification(NotificationItem(
    message.notification?.title ?? 'No Title',
    message.notification?.body ?? 'No Body',
    DateTime.now(),
  ));

  // Show notification
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    message.notification?.title, // Title
    message.notification?.body, // Body
    platformChannelSpecifics,
    payload: message.data['route'], // Use route for navigation if needed
  );

  // Handle navigation to NotificationScreen
  if (message.data['route'] != null) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the auth manager and app state
  await authManager.initialize();
  final appState = FFAppState();
  await appState.initializePersistedState();

  // Get the Firebase messaging token
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getAPNSToken();
  if (token != null) {
    FFAppState().firebaseToken = token;
  }

  // Listen for token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    FFAppState().firebaseToken = newToken;
  });

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });

  // Initialize local notifications (Android & iOS)
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (id, title, body, payload) async {
      // Handle iOS local notifications here
    },
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      if (response.payload != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) =>
                NotificationScreen(), // Handle navigation here
          ),
        );
      }
    },
  );

  // Request permission for notifications (iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
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
  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = rudrakshaCartAuthUserStream()
      ..listen((user) => _appStateNotifier.update(user));

    Future.delayed(
      Duration(milliseconds: 1000),
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
      // navigatorKey: navigatorKey, // Use navigatorKey here
      localizationsDelegates: const [
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
