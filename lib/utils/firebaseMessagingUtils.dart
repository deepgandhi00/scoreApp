import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:score_keeper/di/serializers/serializers.dart';
import 'package:score_keeper/models/notificationMatchModel.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/publicMatchDetails/controllers/publicMatchDetailsController.dart';
import 'package:score_keeper/screens/splash/view/splashView.dart';
import 'package:score_keeper/utils/stringUtils.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
Future<void> onBackGroundMessage(RemoteMessage message) async {
  print('onBackGroundMessage');
  await Firebase.initializeApp();
  FirebaseMessagingUtils.handleMessage(message, false);
}

class FirebaseMessagingUtils {
  static final String NOTIFICATION_CHANNEL = 'notification_channel';
  static final String SCHEDULE_CHANNEL = 'schedule_channel';
  static final firebaseMessaging = FirebaseMessaging.instance;
  static final androidChannel = AndroidNotificationChannel(
      NOTIFICATION_CHANNEL, 'General Alerts',
      importance: Importance.high);
  static final androidScheduleChannel = AndroidNotificationChannel(
      SCHEDULE_CHANNEL, 'Scheduled Notifications',
      importance: Importance.low);
  static final localNotifications = FlutterLocalNotificationsPlugin();
  static final PLAYER_REMINDER_NOTIFICATION_ID = 1;
  static final MATCH_REMINDER_NOTIFICATION_ID = 2;
  static final MATCH_PROGRESS_NOTIFICATION_ID = 3;
  static final MATCH_PROGRESS_NOTIFICATION_ID_2 = 4;
  static final NOTIFICATION_ID = 5;
  static final MATCH_PROGRESS_CHANGE_NOTIFICATION_ID = 6;

  static Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();

    //  handle notifications
    initPushNotifications();
    initLocalNotifications();
    _configureLocalTimeZone();
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    }
  }

  static Future<void> initPushNotifications() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // firebaseMessaging.getInitialMessage().then(handleMessage);
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => handleMessage(message, true));
    FirebaseMessaging.onBackgroundMessage(onBackGroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print('onMessgaeFireBase ${message.data}');
      FirebaseMessagingUtils.handleMessage(message, true);
    });
  }

  static Future<void> initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('ic_notification');
    const settings = InitializationSettings(android: android, iOS: ios);

    await localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      Get.toNamed(SplashView.routeName, arguments: [response.payload]);
    });

    await _requestPermissions();
    final fcmToken = await firebaseMessaging.getToken();
    print('token ${fcmToken}');
    if (fcmToken != null) {
      Utils.addFireBaseToken(fcmToken);
    }
  }

  static Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await localNotifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
    }
  }

  static void handleLocalNotificationClick(String? payload) async {
    if (payload != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey('accessToken')) {
        Map<String, dynamic> data = jsonDecode(payload);
        if (data.isNotEmpty && data.containsKey('screen')) {
          switch (data['screen']) {
            case 'Players':
              Get.toNamed(HomeView.routeName, parameters: {'tab': '2'});
              return;
            case 'Matches':
              Get.toNamed(HomeView.routeName, parameters: {'tab': '1'});
              return;
          }
        }
      }
    }
  }

  static void handleMessage(RemoteMessage? message, bool localNotification) {
    Map<String, dynamic> data = message!.data;

    if (data.containsKey('matchId')) {
      if (Get.isRegistered<PublicMatchDetailsController>()) {
        PublicMatchDetailsController publicMatchDetailsController = Get.find();
        MatchesTabController tabController = Get.find();
        if (publicMatchDetailsController.matchId.toString() ==
            data['matchId']) {
          publicMatchDetailsController.getMatchPlayers(isSilent: true);
        } else {
          // if (Platform.isAndroid && localNotification) {
          //   FirebaseMessagingUtils.showPictureNotification(data);
          // }
        }
        tabController.getAllMatches(isSilent: true);
      } else if (Get.isRegistered<MatchesTabController>()) {
        MatchesTabController matchesTabController = Get.find();
        matchesTabController.getAllMatches(isSilent: true);
        // if (Platform.isAndroid && localNotification) {
        //   FirebaseMessagingUtils.showPictureNotification(data);
        // }
      } else {
        // if (Platform.isAndroid && localNotification) {
        //   FirebaseMessagingUtils.showPictureNotification(data);
        // }
      }
    } else {
      // FirebaseMessagingUtils.showNotification(message!);
    }
  }

  static void schedulePlayerNotification() async {
    await localNotifications.zonedSchedule(
      PLAYER_REMINDER_NOTIFICATION_ID,
      'Players',
      StringUtils.PLAYER_NOTIFICATION,
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 2)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidScheduleChannel.id,
          androidScheduleChannel.name,
          channelDescription: androidScheduleChannel.description,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: getScheduledNotificationsPayload('Players'),
    );
  }

  static void cancelPlayerScheduleNotification() async {
    await localNotifications.cancel(PLAYER_REMINDER_NOTIFICATION_ID);
  }

  static void showNotif() async {
    await localNotifications.show(
      MATCH_REMINDER_NOTIFICATION_ID,
      'Match',
      'You can now add Matches to your team',
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidScheduleChannel.id,
          androidScheduleChannel.name,
          channelDescription: androidScheduleChannel.description,
        ),
      ),
      payload: getScheduledNotificationsPayload('Players'),
    );
  }

  static void scheduleMatchNotification() async {
    await localNotifications.zonedSchedule(
      MATCH_REMINDER_NOTIFICATION_ID,
      'Match',
      StringUtils.MATCH_NOTIFCATION,
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidScheduleChannel.id,
          androidScheduleChannel.name,
          channelDescription: androidScheduleChannel.description,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: getScheduledNotificationsPayload('Matches'),
    );
    Utils.setIsScheduledMatchNotification();
  }

  static void cancelMatchScheduleNotification() async {
    await localNotifications.cancel(MATCH_REMINDER_NOTIFICATION_ID);
  }

  static Future<bool> checkIfNotificationsAreEnabled() async {
    if (Platform.isAndroid) {
      final bool granted = await localNotifications
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      return granted;
    } else {
      final bool granted = await localNotifications
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
          false;
      return granted;
    }
  }

  static String getMatchProgressChangeNotificationTitle(
      NotificationMatchModel notificationMatchModel) {
    if (notificationMatchModel.status == 'IN_PROGRESS') {
      return 'Match Started!';
    } else {
      return 'Match Ended!';
    }
  }

  static String getMatchProgressChangeNotificationMessage(
      NotificationMatchModel notificationMatchModel) {
    if (notificationMatchModel.status == 'IN_PROGRESS') {
      return 'Match Started! ${notificationMatchModel.primaryTeamName} Vs ${notificationMatchModel.secondaryTeamName}';
    } else {
      return 'Match Ended${notificationMatchModel.primaryTeamName} ${notificationMatchModel.primaryGoalCount} - ${notificationMatchModel.secondaryGoalCount} ${notificationMatchModel.secondaryTeamName}.';
    }
  }

  static String getScheduledNotificationsPayload(String toScreen) {
    Map<String, dynamic> data = {};
    data['screen'] = toScreen;
    return jsonEncode(data);
  }

  static void scheduleMatchInProgressNotification(String msg) async {
    await localNotifications.zonedSchedule(
      MATCH_PROGRESS_NOTIFICATION_ID,
      'Match In Progress!',
      msg,
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 20)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidScheduleChannel.id,
          androidScheduleChannel.name,
          channelDescription: androidScheduleChannel.description,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: getScheduledNotificationsPayload('Matches'),
    );
    Utils.setIsScheduledMatchNotification();
  }

  static void cancelScheduleMatchInProgressNotification() async {
    await localNotifications.cancel(MATCH_PROGRESS_NOTIFICATION_ID);
  }

  static void scheduleMatchInProgressNotification2(String msg) async {
    await localNotifications.zonedSchedule(
      MATCH_PROGRESS_NOTIFICATION_ID_2,
      'Match In Progress!',
      msg,
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 40)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidScheduleChannel.id,
          androidScheduleChannel.name,
          channelDescription: androidScheduleChannel.description,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: getScheduledNotificationsPayload('Matches'),
    );
    Utils.setIsScheduledMatchNotification();
  }

  static void cancelScheduleMatchInProgressNotification2() async {
    await localNotifications.cancel(MATCH_PROGRESS_NOTIFICATION_ID_2);
  }
}
