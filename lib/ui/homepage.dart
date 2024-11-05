import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moretimers/cubit/appstate_cubit.dart';
import 'package:moretimers/models/timer.dart';
import 'package:flutter/rendering.dart';
import 'package:moretimers/ui/listtimer.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:wakelock/wakelock.dart';
import 'package:moretimers/cubit/drawer_cubit.dart';
import 'package:moretimers/cubit/list_cubit.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  final state;
  final void displayNotification;
  HomePage({@required this.state, @required this.displayNotification});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  double _fontSize = 28.0;
  double _cardHeight(context) => (MediaQuery.of(context).size.height - 150) / 4;
  // double _cardWidth(context) => (MediaQuery.of(context).size.width - 100);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    super.didChangeAppLifecycleState(appState);
    switch (appState) {
      case AppLifecycleState.paused:
        final appstateCubit = context.read<AppStateCubit>();
        Wakelock.disable();
        appstateCubit.pausedApp();
        break;
      case AppLifecycleState.resumed:
        final appstateCubit = context.read<AppStateCubit>();
        final _wakelock = context.read<DrawerCubit>().state.value;
        if (_wakelock) {
          Wakelock.enable();
        }
        appstateCubit.resumedApp();
        break;
      case AppLifecycleState.inactive:
        final appstateCubit = context.read<AppStateCubit>();
        appstateCubit.inactiveApp();
        break;
      case AppLifecycleState.detached:
        final appstateCubit = context.read<AppStateCubit>();
        appstateCubit.detachedApp();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 103,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          widget.state.repo.timers
                      .map((e) => e.isDeleting ? 0 : 1)
                      .toList()
                      .fold(0, (previous, current) => previous + current) ==
                  0
              ? Center(
                  child: Container(
                    child: Card(
                        // margin: EdgeInsets.all(12),
                        color: Colors.white.withOpacity(.5),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'Click the button below for MoreTimers!',
                            style: TextStyle(
                                fontSize: _fontSize,
                                color: Colors.blue[900],
                                decoration: TextDecoration.none),
                            textAlign: TextAlign.center,
                          ),
                        ))),
                    width: MediaQuery.of(context).size.width,
                    height: _cardHeight(context),
                  ),
                )
              : Expanded(
                  child: Center(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      TimerModel old = widget.state.repo.timers[oldIndex];
                      if (oldIndex > newIndex) {
                        for (int i = oldIndex; i > newIndex; i--) {
                          widget.state.repo.timers[i] =
                              widget.state.repo.timers[i - 1];
                        }
                        widget.state.repo.timers[newIndex] = old;
                      } else {
                        for (int i = oldIndex; i < newIndex - 1; i++) {
                          widget.state.repo.timers[i] =
                              widget.state.repo.timers[i + 1];
                        }
                        widget.state.repo.timers[newIndex - 1] = old;
                      }
                      BlocProvider.of<ListCubit>(context).update();
                    },
                    children: generateList(widget.state.repo.timers),
                  ),
                ))
        ]));
  }

  List<Widget> generateList(List<TimerModel> timers) {
    List<Widget> list = timers
        .map((timer) => Row(
              key: timer.key,
              children: [
                ItemTile(
                  key: ObjectKey(timer),
                  itemcounter: widget.state.repo.timers
                          .sublist(0, widget.state.repo.timers.indexOf(timer))
                          .map((e) => e.isDeleting ? 0 : 1)
                          .toList()
                          .fold(0, (previous, current) => previous + current) +
                      1,
                  timercounter: widget.state.repo.timers
                          .sublist(0, widget.state.repo.timers.indexOf(timer))
                          .map((e) => e.timer == timer_type.timer &&
                                  e.isDeleting == false
                              ? 1
                              : 0)
                          .toList()
                          .fold(0, (previous, current) => previous + current) +
                      1,
                  stopwatchcounter: widget.state.repo.timers
                          .sublist(0, widget.state.repo.timers.indexOf(timer))
                          .map((e) => e.timer == timer_type.stopwatch &&
                                  e.isDeleting == false
                              ? 1
                              : 0)
                          .toList()
                          .fold(0, (previous, current) => previous + current) +
                      1,
                  index: widget.state.repo.timers.indexOf(timer),
                  title: timer.title,
                  color: Color(int.parse(
                      timer.color.split('(0x')[1].split(')')[0],
                      radix: 16)),
                  timer: timer,
                  onDeletePressed: (id) {
                    BlocProvider.of<ListCubit>(context).delete(id);
                  },
                ),
              ],
            ))
        .toList();
    return list;
  }
}
