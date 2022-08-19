import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constans.kdefultAppColor,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constans.kdefualtAppPading),
          child: Text(
            'Settings',
            style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
          ),
        ),
        centerTitle: false,
      ),   
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constans.kdefualtAppPading),
        child: Column(
          children: [
            BuildListTile(
              color: Colors.white.withOpacity(0.8),
              icon: Icons.person,
              ontap: () async {
                await launchUrl(Uri.parse(
                    'https://main--nostalgic-jennings-63dd2f.netlify.app/'));
              },
              subtitleIcon: Icons.person,
              textStyle: context.textTheme.subtitle1,
              visibilityArrowIcons: false,
              title: 'About us',
              trailing: '',
            )
          ],
        ),
      ),
    );
  }
}
