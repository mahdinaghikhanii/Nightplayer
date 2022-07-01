import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/buildchip_bloc/buildchip_state.dart';
import 'package:nightplayer/module/enum.dart';

class BuildChipCubit extends Cubit<BuildChipState> {
  BuildChipCubit() : super(const BuildChipState(BuildChip.artist, 0));

  void getBuildChipIteam(BuildChip buildChip) {
    switch (buildChip) {
      case BuildChip.artist:
        emit(const BuildChipState(BuildChip.artist, 0));
        break;
      case BuildChip.album:
        emit(const BuildChipState(BuildChip.album, 1));
        break;
      case BuildChip.playlist:
        emit(const BuildChipState(BuildChip.playlist, 2));
        break;
      default:
    }
  }
}
