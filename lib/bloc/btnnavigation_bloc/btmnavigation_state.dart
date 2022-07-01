import 'package:equatable/equatable.dart';

import '../../module/enum.dart';

class BtmNavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const BtmNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
