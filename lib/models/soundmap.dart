import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Map<String, String> soundList = {
  'Alarm': 'assets/household_alarm_clock_beep_tone.mp3',
  'Bear': 'assets/animals_bear_growl_002.mp3',
  'Bright':
      'assets/zapsplat_multimedia_alert_bright_warm_system_positive_001_57863.mp3',
  'Dog':
      'assets/zapsplat_animals_dog_puppy_several_weeks_old_barking_ridgeback_cross_bullmastiff_008_56152.mp3',
  'Dreamy':
      'assets/zapsplat_multimedia_alert_dreamy_soft_warm_drippy_delayed_bells_positive_002_57873.mp3',
  'Safari': 'assets/audio_hero_Hyena_DIGIC12-31.mp3',
  'Whistle':
      'assets/zapsplat_cartoon_slide_whistle_up_down_slow_speed_001_49200.mp3',
};

class NotificationSound {
  int duration;
  int id;
  String title;
  NotificationSound(
      {@required this.duration, @required this.id, @required this.title});

  void mapSoundtoNotification(sound) {
    duration = duration * 100;

    if (sound == 'Alarm') {
      _showNotificationAlarmSound(duration, id, title);
      // _showNotificationAlarmSound();
    } else if (sound == 'Bear') {
      _showNotificationBearSound(duration, id, title);
    } else if (sound == 'Bright') {
      _showNotificationBrightSound(duration, id, title);
    } else if (sound == 'Dog') {
      _showNotificationDogSound(duration, id, title);
    } else if (sound == 'Dreamy') {
      _showNotificationDreamySound(duration, id, title);
    } else if (sound == 'Safari') {
      _showNotificationSafariSound(duration, id, title);
    } else if (sound == 'Whistle') {
      _showNotificationWhistleSound(duration, id, title);
    } else {
      _showNotificationAlarmSound(duration, id, title);
    }
  }

  Future<void> _showNotificationAlarmSound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Alarm Sound',
      'More Timers Notifications Alarm',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound(
          'household_alarm_clock_beep_tone'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> _showNotificationBearSound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Bear Sound',
      'More Timers Notifications Bear',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound('animals_bear_growl_002'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> _showNotificationBrightSound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Bright Sound',
      'More Timers Notifications Bright',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound(
          'zapsplat_multimedia_alert_bright_warm_system_positive_001_57863'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> _showNotificationDogSound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Dog Sound',
      'More Timers Notifications Dog',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound(
          'zapsplat_animals_dog_puppy_several_weeks_old_barking_ridgeback_cross_bullmastiff_008_56152'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> _showNotificationDreamySound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Dreamy Sound',
      'More Timers Notifications Dreamy',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound(
          'zapsplat_multimedia_alert_dreamy_soft_warm_drippy_delayed_bells_positive_002_57873'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> _showNotificationSafariSound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Safari Sound',
      'More Timers Notifications Safari',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound('audio_hero_hyena'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> _showNotificationWhistleSound(
      int duration, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'More Timers Notification Whistle Sound',
      'More Timers Notifications Whistle',
      'Custom Sound Notification for moretimers App',
      sound: RawResourceAndroidNotificationSound(
          'zapsplat_cartoon_slide_whistle_up_down_slow_speed_001_49200'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    if (duration == 0) {
      await flutterLocalNotificationsPlugin.show(id, 'Time is up!',
          title ?? 'Untitled timer' + ' complete!', platformChannelSpecifics);
    } else {
      tz.initializeTimeZones();
      var tztime = tz.TZDateTime.now(tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Time is up!',
          title + ' complete!',
          tztime.add(Duration(milliseconds: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }
}
