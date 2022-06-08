import 'package:flutter/material.dart';

import '../bloc/statebloc.dart';
import '../module/constans.dart';

class Home extends StatelessWidget {
  final StateBloc stateBloc;
  const Home({Key? key, required this.stateBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constans.kdefultAppColor,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Constans.kdefualtAppPading),
          child: Text(
            'NightPlayer',
          ),
        ),
        centerTitle: false,
      ),
    );
  }
}
