import 'package:flutter/material.dart';
import 'package:moretimers/models/timer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moretimers/ui/newtimerpopup.dart';

class SpeedDialGenerator {
  final timer_type timer;
  final BuildContext context;
  final _formKey = GlobalKey<FormState>();

  SpeedDialGenerator({this.timer, this.context});

  SpeedDial buildSpeedDial(
    context,
  ) {
    return SpeedDial(
      elevation: 12,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.timer, color: Colors.black),
          backgroundColor: Colors.blue[200],
          onTap: () {
            NewTimerPopUp popUp = NewTimerPopUp(timer: timer_type.timer);
            popUp.popUp(context, _formKey);
          },
          label: 'Create Timer',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue[200],
        ),
        SpeedDialChild(
          child: Icon(Icons.access_alarm, color: Colors.white),
          backgroundColor: Colors.blue[900],
          onTap: () {
            NewTimerPopUp popUp = NewTimerPopUp(timer: timer_type.stopwatch);
            popUp.popUp(context, _formKey);
          },
          label: 'Create Stopwatch',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.blue[900],
        ),
      ],
    );
  }
}
