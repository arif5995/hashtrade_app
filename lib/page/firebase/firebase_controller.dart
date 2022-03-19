import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../data/models/pushnotification_model.dart';

class FirebaseController extends GetxController {
  late final FirebaseMessaging _messaging;
  var _totalNotifications = 0.obs;
  PushNotification? _notificationInfo;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void registerNotification() async {
    print("registerNotification");
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, sound: true, provisional: true, badge: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        _notificationInfo = notification;
        _totalNotifications++;
        update();

        if (_notificationInfo != null) {
          print("Data $_notificationInfo");
          Get.snackbar(
            message.notification!.title!,
            message.notification!.body!,
            onTap: (_) {},
            duration: Duration(seconds: 4),
            animationDuration: Duration(milliseconds: 800),
            snackPosition: SnackPosition.TOP,
          );
          print("NOTIF ${_notificationInfo!.title}");
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void notifInBackground() async {
    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      _notificationInfo = notification;
      _totalNotifications++;
    });
  }

  // For handling notification when the app is in terminated state
  void checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      _notificationInfo = notification;
      _totalNotifications++;
    }
  }
}
