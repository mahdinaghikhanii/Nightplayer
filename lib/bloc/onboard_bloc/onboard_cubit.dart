import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/onboard_bloc/onboard_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardCubit extends Cubit<OnboardState> {
  OnBoardCubit() : super(OnBoards()) {
    checkIfFirstTimeUserSeeOnBoarding();
  }

  void saveUserSeeOnBoard() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('ON_BOARD', 0);
  }

  void checkIfFirstTimeUserSeeOnBoarding() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    int number = sharedPreferences.getInt('ON_BOARD') ?? 1;

    number != 0 ? emit(LoadOnboard()) : emit(OnBoards());
  }
}
