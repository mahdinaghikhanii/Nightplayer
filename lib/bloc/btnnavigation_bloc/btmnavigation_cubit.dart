import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/module/navbar_items.dart';

import 'btmnavigation_state.dart';

class BtmNavigationCubit extends Cubit<BtmNavigationState> {
  BtmNavigationCubit() : super(const BtmNavigationState(NavbarItem.allsong, 0));

  void getNavbarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.allsong:
        emit(const BtmNavigationState(NavbarItem.allsong, 0));
        break;
      case NavbarItem.album:
        emit(const BtmNavigationState(NavbarItem.album, 1));
        break;
      case NavbarItem.favorite:
        emit(const BtmNavigationState(NavbarItem.favorite, 2));
        break;
      case NavbarItem.settings:
        emit(const BtmNavigationState(NavbarItem.settings, 3));
        break;
      default:
    }
  }
}
