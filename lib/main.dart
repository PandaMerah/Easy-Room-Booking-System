import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/repositories/authentication_repository.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'firebase_options.dart';
import 'app.dart';

Future<void> main() async {
  // Widgets Biding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Notification Initialize
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: "reminder_channel_group",
        channelKey: "reminder_channel",
        channelName: "Room Reminder",
        channelDescription: "Channel for Room Reminder")
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "reminder_channel_group",
        channelGroupName: "Basic Group")
  ]);
  bool isAllowedToSendNotifications =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // GetX Local Storage
  await GetStorage.init();

  // Await splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}
