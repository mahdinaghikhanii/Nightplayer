import 'package:shared_preferences/shared_preferences.dart';

class OnBoardPerfs {
  void storeInBoardScreansInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('InBoardScreans', isViewed);
  }
}
