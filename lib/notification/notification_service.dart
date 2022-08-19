import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  notify(String imageSong, String artist, String nameSong, int id) async {
    // String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            groupKey: 'music_group',
            channelKey: 'music_chanel',
            notificationLayout: NotificationLayout.MediaPlayer,
            roundedLargeIcon: true,
            roundedBigPicture: false,
            hideLargeIconOnExpand: false,
            largeIcon: 'asset://assets/img/onbo.png',
            title: artist,
            criticalAlert: false,
            category: NotificationCategory.Social,
            body: nameSong),
        actionButtons: <NotificationActionButton>[
          NotificationActionButton(
              showInCompactView: false,
              // isDangerousOption: true,
              key: 'yes',
              //zicon: 'asset://assets/icon/back.png',
              //   enabled: true,
              // autoDismissible: true,
              color: Colors.white,
              buttonType: ActionButtonType.KeepOnTop,
              label: 'asset://assets/icon/back.png'),
        ]);
    /*   AwesomeNotifications().actionStream.listen((action) {
      if (action.buttonKeyPressed == "DISMISS") {
        print("Open button is pressed");
      } else if (action.buttonKeyPressed == "d") {
        print("Delete button is pressed.");
      }
    });*/
  }
}
