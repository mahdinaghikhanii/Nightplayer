import 'package:flutter_bloc/flutter_bloc.dart';

import 'statebloc.dart';

class AudioBloc extends Cubit<StateBloc> {
  AudioBloc() : super(Initial()) {}

  nextAudio() async {}

  stopAudio() async {}

  backAudio() async {}

  playAudio() async {}
}
