import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  void notify() async {
    String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          groupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          bigPicture:
              'https://cdn.motor1.com/images/mgl/mrz1e/s1/coolest-cars-feature.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          title: 'Simple Notification',
          body: 'Simple body'),
    );
  }
}
