import 'package:flutter/material.dart';
import 'package:moretimers/models/soundmap.dart';
import 'package:moretimers/models/timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moretimers/bloc/timer_bloc_export.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moretimers/cubit/appstate_cubit.dart';
import 'package:moretimers/cubit/list_cubit.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ItemTile extends StatefulWidget {
  final Function(String) onDeletePressed;
  final int index;
  final TimerModel timer;
  final itemcounter;
  final key; // = UniqueKey();
  final String title;
  final Color color;
  final int stopwatchcounter;
  final int timercounter;

  ItemTile({
    Key key,
    this.title,
    this.color = Colors.white,
    @required this.index,
    @required this.itemcounter,
    @required this.stopwatchcounter,
    @required this.timercounter,
    @required this.timer,
    @required this.onDeletePressed,
  })  : key = ValueKey(timer.id),
        super(key: key);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> with WidgetsBindingObserver {
  double _cardHeight(context) => (MediaQuery.of(context).size.height - 150) / 4;
  DateTime _endingTime;
  DateTime _startTime;
  String _timerState = '';
  String _pausedTimerState = '';

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _checkTimerState(String state) {
    _timerState = state;
  }

  int _endingDuration = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(
          key: ValueKey(widget.timer.id), timer: widget.timer, context: context)
        ..add(widget.timer.timerstate == "TimerRunInProgress"
            ? TimerUpdated(
                duration: widget.timer.duration,
                delta: (DateTime.now()
                            .difference(DateTime.parse(widget.timer.endTime))
                            .inMilliseconds /
                        100)
                    .round())
            : TimerPaused()),
      child: BlocListener(
        cubit: BlocProvider.of<AppStateCubit>(context),
        listener: (BuildContext context, state) {
          if (state.toString() == 'AppStateResumed' &&
              _pausedTimerState == 'TimerRunInProgress') {
            _startTime = DateTime.now();
            BlocProvider.of<TimerBloc>(context).add(TimerResumed());
            BlocProvider.of<TimerBloc>(context).add(TimerUpdated(
                duration: _endingDuration,
                delta: (_startTime.difference(_endingTime).inMilliseconds / 100)
                    .round()));
            flutterLocalNotificationsPlugin.cancel(int.parse(widget.timer.id));
          } else if (state.toString() == 'AppStatePaused') {
            _pausedTimerState = _timerState.split(' ')[0];
            _endingDuration =
                BlocProvider.of<TimerBloc>(context).state.duration;
            widget.timer.endTime = DateTime.now().toString();
            BlocProvider.of<ListCubit>(context).update();
            _endingTime = DateTime.now();
            if (widget.timer.timer == timer_type.timer &&
                _pausedTimerState == 'TimerRunInProgress') {
              NotificationSound _notification = NotificationSound(
                  title: widget.timer.title == null
                      ? "Timer " + widget.timercounter.toString()
                      : widget.timer.title,
                  duration: _endingDuration,
                  id: int.parse(widget.timer.id));
              _notification.mapSoundtoNotification(widget.timer.sound);
            }

            BlocProvider.of<TimerBloc>(context).add(TimerPaused());
          }
        },
        child: Visibility(
          visible: widget.timer.isDeleting ? false : true,
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: widget.color == Colors.black ||
                    widget.color == Colors.grey ||
                    widget.color.toString() ==
                        'MaterialColor(primary value: Color(0xff607d8b))'
                ? Colors.white
                : Colors.black,
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    color: widget.color.withOpacity(.5),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: _cardHeight(context),
                          child: Row(
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.title == null || widget.title == ""
                                          ? widget.timer.timer ==
                                                  timer_type.stopwatch
                                              ? 'Stopwatch: ${widget.stopwatchcounter}'
                                              : 'Timer: ${widget.timercounter}'
                                          : widget.title,
                                      style: TextStyle(
                                          color: widget.color == Colors.black ||
                                                  widget.color == Colors.grey ||
                                                  widget.color.toString() ==
                                                      'MaterialColor(primary value: Color(0xff607d8b))'
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: _cardHeight(context) / 8),
                                    ),
                                    BlocConsumer<TimerBloc, TimerState>(
                                      listener: (context, state) {
                                        _checkTimerState(state.toString());
                                        BlocProvider.of<ListCubit>(context)
                                            .update();
                                      },
                                      builder: (context, state) {
                                        final String hourStr =
                                            ((state.duration / 36000) % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                        final String minutesStr =
                                            ((state.duration / 600) % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                        final String secondsStr =
                                            ((state.duration / 10) % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                        final String milisecondsStr =
                                            (state.duration)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                        return Row(
                                          children: [
                                            Container(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                                color: Colors.blueGrey[50],
                                                elevation: 5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          24, 8, 24, 8),
                                                  child: Text(
                                                    // '${state.duration}',
                                                    '$hourStr:$minutesStr:$secondsStr:${milisecondsStr.substring(milisecondsStr.length - 1)}',
                                                    style: TextStyle(
                                                        fontSize: _cardHeight(
                                                                context) /
                                                            4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BlocBuilder<TimerBloc, TimerState>(
                                                builder: (context, state) {
                                              return IconButton(
                                                icon: Icon(
                                                  Icons.highlight_remove,
                                                  color: Colors.red,
                                                  size:
                                                      _cardHeight(context) / 5,
                                                ),
                                                onPressed: () {
                                                  widget.onDeletePressed(
                                                      widget.timer.id);
                                                  BlocProvider.of<TimerBloc>(
                                                          context)
                                                      .add(TimerDestroyed());
                                                },
                                              );
                                            })
                                          ],
                                        );
                                      },
                                    ),
                                    // ),
                                    BlocBuilder<TimerBloc, TimerState>(
                                      buildWhen:
                                          (previousState, currentState) =>
                                              currentState.runtimeType !=
                                              previousState.runtimeType,
                                      builder: (context, state) =>
                                          TimerActions(timer: widget.timer),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey[100], spreadRadius: 1)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                        child: Text('${(widget.itemcounter).toString()}',
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                    )),
              )
            ]),
          ),
          // ),
        ),
        // ),
      ),
    );
  }
}
