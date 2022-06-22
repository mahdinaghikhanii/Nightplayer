import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  notify(String imageSong, String artist, String nameSong, int id) async {
    // String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            groupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            notificationLayout: NotificationLayout.MediaPlayer,
            roundedLargeIcon: true,
            roundedBigPicture: false,
            hideLargeIconOnExpand: false,
            largeIcon: 'asset://assets/icon/song96.png',
            title: artist,
            criticalAlert: false,
            body: nameSong),
        actionButtons: [
          NotificationActionButton(
              enabled: true,
              key: 'DISMISS',
              label: 'Next',
              autoDismissible: true,
              showInCompactView: true,
              color: Colors.white,
              buttonType: ActionButtonType.Default,
              isDangerousOption: true),
          NotificationActionButton(
              enabled: true,
              key: 'back',
              label: 'Back',
              autoDismissible: true,
              showInCompactView: true,
              color: Colors.white,
              buttonType: ActionButtonType.Default,
              isDangerousOption: true),
          NotificationActionButton(
            label: 'pause',
            enabled: true,
            buttonType: ActionButtonType.Default,
            key: 'pause',
          )
        ]);
    AwesomeNotifications().actionStream.listen((action) {
      if (action.buttonKeyPressed == "DISMISS") {
        print("Open button is pressed");
      } else if (action.buttonKeyPressed == "d") {
        print("Delete button is pressed.");
      }
    });
  }
}
