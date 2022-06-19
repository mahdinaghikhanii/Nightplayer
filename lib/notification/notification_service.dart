import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  notify(String imageSong, String artist, String nameSong) async {
    //String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            largeIcon: 'asset://assets/img/call.jpg',
            id: 1,
            groupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            notificationLayout: NotificationLayout.BigPicture,
            title: artist,
            body: nameSong),
        actionButtons: [
          NotificationActionButton(
            key: "open",
            label: "Open File",
          ),
          NotificationActionButton(
            key: "delete",
            label: "Delete File",
          )
        ]);
    AwesomeNotifications().actionStream.listen((action) {
      if (action.buttonKeyPressed == "open") {
        print("Open button is pressed");
      } else if (action.buttonKeyPressed == "delete") {
        print("Delete button is pressed.");
      }
    });
  }
}
