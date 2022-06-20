import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  notify(String imageSong, String artist, String nameSong) async {
    String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            bigPicture: 'asset://assets/img/call.jpg',
            id: 1,
            groupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            notificationLayout: NotificationLayout.BigPicture,
            title: artist,
            body: nameSong),
        actionButtons: [
          NotificationActionButton(
            key: "next",
            label: 'next',
          ),
          NotificationActionButton(
            key: "delete",
            label: "Delete File",
          ),
          NotificationActionButton(
            key: "back",
            label: "back",
          )
        ]);
    AwesomeNotifications().actionStream.listen((action) {
      if (action.buttonKeyPressed == "next") {
        print("Open button is pressed");
      } else if (action.buttonKeyPressed == "") {
        print("Delete button is pressed.");
      }
    });
  }

  void notificarionPlay() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 2,
          channelKey: 'media_player',
          bigPicture: 'asset://assets/img/call.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          title: "Mehard",
          body: "Kaj"),
    );
  }
}
