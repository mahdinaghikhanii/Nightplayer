import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/module/navbar_items.dart';

import 'btmnavigation_state.dart';

class BtmNavigationCubit extends Cubit<BtmNavigationState> {
  BtmNavigationCubit() : super(DefaultScreens(NavbarItem.home, 0));

  void getNavbarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(DefaultScreens(NavbarItem.home, 0));
        break;
      case NavbarItem.album:
        emit(DefaultScreens(NavbarItem.album, 1));
        break;
      case NavbarItem.favorite:
        emit(DefaultScreens(NavbarItem.favorite, 2));
        break;
      case NavbarItem.settings:
        emit(DefaultScreens(NavbarItem.settings, 3));
        break;
      default:
    }
  }
}
