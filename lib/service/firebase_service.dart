import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mss_e_learning/main.dart';
import 'package:mss_e_learning/util/app_routes.dart';

class FirebaseService {
  /// Using firebase doc
  ///https://firebase.google.com/docs/flutter/setup?platform=android
  ///https://firebase.google.com/docs/cli#setup_update_cli
  ///https://firebase.google.com/docs/cloud-messaging/flutter/receive
  ///https://www.youtube.com/watch?v=BVZ160KG5Kc&list=PLFyjjoCMAPtzvnHnby5Yu9idvwqXI-ujn&index=6
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = AndroidNotificationChannel(
      Random.secure().nextInt(1000000).toString(),
      'High Importance Notifications',
      description: "This channel is used for important notifications",
      importance: Importance.high);
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");

      /// Store the token on your server for sending targeted messages
    });

    /// Handle background messages by registering a onBackgroundMessage handler.
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    ///initialize local notification before using it
    initLocalNotifications();

    /// To handle messages while your application is in the foreground, listen to the onMessage stream.
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      print("Forground Notification ${notification?.title}");
      if (notification == null) return;

      ///There is something not working with local notifications
      //TODO : fIX LOCAL NOTIFICATIONS
      Future.delayed(Duration.zero, () {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                importance: Importance.high,
                priority: Priority.max,
                icon: '@drawable/ic_launcher'),
          ),
          payload: jsonEncode(message.toMap())
        );
      });
    });

    /// If your app is opened via a notification whilst the app is terminated,
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    /// If the application has been opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _localNotifications.initialize(setting,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload as String));
      handleMessage(message);
    });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.requestNotificationsPermission();
    await platform?.createNotificationChannel(_androidChannel);
  }

// Future<void> checkTokenRegistration(bool login) async {
//   final prefs = await SharedPreferences.getInstance();
//   final tokenRegistered = prefs.getBool('firebase_token_registered') ?? false;
//   if (tokenRegistered && !login) {
//   } else {
//     final access_token = await AuthService.getAuthorizationToken();
//     if(access_token == null){
//       return;
//     }
//     final fCMToken = await _firebaseMessaging.getToken();
//     final body = {"token": fCMToken};
//     var response =
//         await http.post(Uri.parse("${Constants.API}/register_token"),
//             headers: {
//               "Content-type": "application/json",
//               'Authorization': 'Bearer $access_token',
//             },
//             body: json.encode(body));
//     if (response.statusCode == 200) {
//       await prefs.setBool('firebase_token_registered', true);
//     }
//   }
// }
}

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

@pragma('vm:entry-point')
void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  navigatorKey.currentState?.pushNamed(AppRoutes.splash);
}
