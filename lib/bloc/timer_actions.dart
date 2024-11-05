import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moretimers/bloc/timer_bloc_export.dart';
import 'package:moretimers/cubit/list_cubit.dart';
import 'package:moretimers/models/timer.dart';

class TimerActions extends StatelessWidget {
  final TimerModel timer;
  TimerActions({@required this.timer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _mapStateToActionButtons(
            timerBloc: BlocProvider.of<TimerBloc>(context),
            context: context,
            timer: timer),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
    BuildContext context,
    TimerModel timer,
  }) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
              elevation: 10,
              child: Icon(Icons.play_arrow),
              onPressed: () {
                timer.timerstate = "TimerRunInProgress";
                BlocProvider.of<ListCubit>(context).update();

                timerBloc.add(TimerStarted(duration: currentState.duration));
              }),
        ),
      ];
    }
    if (currentState is TimerRunInProgress) {
      return [
        Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
              elevation: 10,
              child: Icon(Icons.pause),
              onPressed: () {
                timer.timerstate = "TimerRunPaused";
                BlocProvider.of<ListCubit>(context).update();
                timerBloc.add(TimerPaused());
              }),
        ),
        Container(
          width: 10,
        ),
        Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
              elevation: 10,
              child: Icon(Icons.replay),
              onPressed: () {
                timer.timerstate = "TimerRunInProgress";
                timer.duration = timer.initialduration;
                BlocProvider.of<ListCubit>(context).update();
                timerBloc.add(TimerReset());
              }),
        ),
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
              elevation: 10,
              child: Icon(Icons.play_arrow),
              onPressed: () {
                timer.timerstate = "TimerRunInProgress";
                // timer.duration = timer.initialduration;
                BlocProvider.of<ListCubit>(context).update();
                timerBloc.add(TimerResumed());
              }),
        ),
        Container(
          width: 10,
        ),
        Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
              elevation: 10,
              child: Icon(Icons.replay),
              onPressed: () {
                timer.timerstate = "TimerRunInitial";
                timer.duration = timer.initialduration;
                BlocProvider.of<ListCubit>(context).update();
                timerBloc.add(TimerReset());
              }),
        ),
      ];
    }
    if (currentState is TimerRunComplete) {
      return [
        Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
              elevation: 10,
              child: Icon(Icons.replay),
              onPressed: () {
                timer.timerstate = "TimerInitial";
                timer.duration = timer.initialduration;
                BlocProvider.of<ListCubit>(context).update();
                timerBloc.add(TimerReset());
              }),
        ),
      ];
    }
    return [];
  }
}
