import 'package:flutter/foundation.dart';
import 'package:nightplayer/module/navbar_items.dart';

@immutable
abstract class BtmNavigationState {}

class Wating extends BtmNavigationState {}

class DefaultScreens extends BtmNavigationState {
  NavbarItem navbarItem;
  int index;
  DefaultScreens(this.navbarItem, this.index);
}

class FirstScreans extends BtmNavigationState {}

class Second extends BtmNavigationState {}

class ThirdPage extends BtmNavigationState {}
