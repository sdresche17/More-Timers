import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moretimers/cubit/timerpopup_cubit.dart';
import 'package:flutter/rendering.dart';
import 'package:moretimers/ui/speeddial.dart';
import 'package:moretimers/ui/homepage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moretimers/cubit/appstate_cubit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:moretimers/ui/drawer.dart';
import 'package:moretimers/cubit/drawer_cubit.dart';
import 'package:moretimers/ui/hourglass_background.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:moretimers/cubit/list_cubit.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // BlocObserver = HydratedBloc.build();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('moretimers_icon');

  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpeedDialGenerator speedDial = SpeedDialGenerator();
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DrawerCubit(value: false),
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        drawer: SafeArea(
          child: AppDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('MoreTimers'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Image.asset('assets/images/moretimers_white.png'),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(children: [
          HourglassBackground(),
          MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => ListCubit()..fetch()),
                BlocProvider(
                  create: (context) => AppStateCubit(),
                )
              ],
              child: BlocBuilder<ListCubit, ListState>(
                builder: (context, state) {
                  if (state is Failure) {
                    return Center(
                      child: Text('Oops something went wrong!'),
                    );
                  }
                  if (state is Loaded) {
                    return Stack(children: [
                      HomePage(
                        state: state,
                        displayNotification: () => {},
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                        child: BlocProvider(
                            create: (context) => TimerpopupCubit(),
                            child: speedDial.buildSpeedDial(context)),
                      ),
                    ]);
                  }
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text(state.toString());
                },
              )),
        ]),
      ),
    );
  }
}
