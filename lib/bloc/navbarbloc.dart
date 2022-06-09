import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocEvent {}

class NavbarBloc extends Cubit<int> {
  NavbarBloc() : super(0);
}
