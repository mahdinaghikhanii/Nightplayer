import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  notify(
    String imageSong,
    String artist,
    String nameSong,
    int id,
  ) async {
    // String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            backgroundColor: Colors.black,
            color: Colors.white,
            id: id,
            groupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            notificationLayout: NotificationLayout.MediaPlayer,
            roundedLargeIcon: true,
            roundedBigPicture: false,
            hideLargeIconOnExpand: false,
            largeIcon: 'asset://assets/img/kaj.jpg',
            title: artist,
            criticalAlert: false,
            body: nameSong),
        actionButtons: [
          NotificationActionButton(
              enabled: true,
              key: 'next',
              label: 'Next',
              autoDismissible: true,
              showInCompactView: true,
              icon: Icons.abc.toString(),
              color: Colors.white,
              buttonType: ActionButtonType.Default,
              isDangerousOption: true),
          NotificationActionButton(
              enabled: true,
              key: 'pasuse',
              label: 'Back',
              autoDismissible: true,
              showInCompactView: true,
              color: Colors.red,
              buttonType: ActionButtonType.Default,
              isDangerousOption: true),
          NotificationActionButton(
            color: Colors.white,
            label: 'back',
            enabled: true,
            buttonType: ActionButtonType.Default,
            key: 'pause',
          )
        ]);
    AwesomeNotifications().actionStream.listen((action) {
      if (action.buttonKeyPressed == "next") {
        action.color = Colors.white;
        //  print("Open button is pressed");
      } else if (action.buttonKeyPressed == "pasuse") {
        // print("Delete button is pressed.");
      } else if (action.buttonKeyPressed == "back") {
        // print("Delete button is pressed.");
      }
    });
  }
}
