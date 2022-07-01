import 'package:equatable/equatable.dart';

import '../../module/enum.dart';

class BuildChipState extends Equatable {
  final BuildChip buildChip;
  final int index;

  const BuildChipState(this.buildChip, this.index);

  @override
  List<Object> get props => [buildChip, index];
}
