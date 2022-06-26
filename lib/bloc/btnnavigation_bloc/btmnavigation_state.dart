import 'package:equatable/equatable.dart';
import 'package:nightplayer/module/navbar_items.dart';

class BtmNavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const BtmNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
