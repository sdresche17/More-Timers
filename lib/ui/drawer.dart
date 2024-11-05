import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moretimers/cubit/drawer_cubit.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerCubit, DrawerState>(builder: (context, state) {
      return Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createHeader(),
                  Row(
                    children: [
                      Expanded(
                        child: _createDrawerItem(
                            icon: Icons.screen_lock_portrait,
                            text: 'Keep Screen On'),
                      ),
                      Switch(
                          value: state.value,
                          onChanged: (value) {
                            context.read<DrawerCubit>().changeWakeLock(value);
                          }),
                    ],
                  ),
                  InkWell(
                      onTap: () => _launchURL(),
                      child: _createDrawerItem(
                          icon: Icons.bug_report, text: 'Report an issue')),
                  InkWell(
                      onTap: () => showLicensePage(
                            context: context,
                            applicationIcon: Image.asset(
                                'assets/images/moretimers_icon.png'),
                            // applicationName: "More Timers"
                            // Other parameters
                          ),
                      child:
                          _createDrawerItem(icon: Icons.book, text: 'Legal')),
                  InkWell(
                      onTap: () => showMyDialog(context),
                      child: _createDrawerItem(
                          icon: Icons.privacy_tip, text: 'Privacy Policy')),
                  Column(
                    children: [
                      _createDrawerItem(icon: Icons.info, text: 'About:'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                        child: Text(
                          'Hey! Thanks for supporting More Timers! Our goal is to provide an easy, inexpensive, productivity tool that improves your daily life. If you have any comments or concerns please feel free to reach out by tapping the "Report an Issue" button above.\n\nSound effects from:\n https://www.zapsplat.com',
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Version: 0.9.0'),
              onTap: () {},
            ),
          ],
        ),
      );
    });
    // );
  }
}

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('We don\'t collect any data...shocking we know!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black)),
          color: Colors.blue[50],
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/moretimers_icon.png'))),
      child: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         fit: BoxFit.fitHeight,
          //         image: AssetImage('assets/images/moretimers_icon.png'))
          ));
}

_launchURL() async {
  const url = 'mailto:<moretimerhelp@gmail.com>?subject=moretimers Support';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
