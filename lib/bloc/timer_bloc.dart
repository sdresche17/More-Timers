import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:moretimers/bloc/timer_bloc_export.dart';
import 'package:moretimers/models/timer.dart';
import 'package:flutter/material.dart';
import 'package:moretimers/models/soundmap.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './timer_bloc_export.dart';
import 'package:moretimers/cubit/list_cubit.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerModel _timer;
  final BuildContext _context;

  TimerBloc(
      {@required Key key,
      @required TimerModel timer,
      @required BuildContext context})
      : assert(timer != null),
        _timer = timer,
        _context = context,
        super(TimerInitial(timer.duration));
  StreamSubscription<int> _tickerSubscription;

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    // print(transition);
    super.onTransition(transition);
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: _context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time\'s up!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _timer.title == null
                    ? Text('Times up! Hit "okay" to silence the alarm.')
                    : Text(
                        'Times up! ${_timer.title} finished, hit "okay" to silence alarm.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                flutterLocalNotificationsPlugin.cancel(int.parse(_timer.id));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// FIX DURATION
  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
    // BuildContext context
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerReset) {
      yield* _mapTimerResetToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    } else if (event is TimerDestroyed) {
      yield* _mapTimerDestroyedToState(event);
    } else if (event is TimerUpdated) {
      yield* _mapTimerUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerRunInProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _timer
        .tick(timer: _timer.timer, starttime: _timer.duration)
        .listen((duration) {
      _timer.duration = duration;
      add(TimerTicked(duration: duration));
    });
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitial(_timer.initialduration);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    if (tick.duration > 0 || _timer.timer == timer_type.stopwatch) {
      yield TimerRunInProgress(tick.duration);
      if (tick.duration == 1 && _timer.timer == timer_type.timer) {
        _timer.timerstate = "TimerRunComplete";
        BlocProvider.of<ListCubit>(_context).update();
        showMyDialog();
        NotificationSound _notification = NotificationSound(
            title: _timer.title, duration: 0, id: int.parse(_timer.id));
        _notification.mapSoundtoNotification(_timer.sound);
      }
    } else {
      yield TimerRunComplete();
    }
  }

  Stream<TimerState> _mapTimerDestroyedToState(TimerDestroyed destroy) async* {
    close();
  }

  Stream<TimerState> _mapTimerUpdatedToState(TimerUpdated update) async* {
    print("UPDATED: " + update.toString());
    _tickerSubscription?.cancel();
    _tickerSubscription = _timer
        .tick(
            timer: _timer.timer,
            delta: update.delta,
            starttime: update.duration)
        .listen((duration) {
      _timer.duration = duration;

      add(TimerTicked(duration: duration));
    });
    yield TimerRunInProgress(state.duration);
  }
}
