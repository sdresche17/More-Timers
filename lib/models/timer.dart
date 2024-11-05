import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:json_annotation/json_annotation.dart';
part 'timer.g.dart';
// part 'timermodel.g.dart';

enum timer_type { stopwatch, timer }

@JsonSerializable()
class TimerModel {
  final timer_type timer;
  int duration;
  final String id;
  final bool isDeleting;
  final String color;
  final String title;
  final String sound;
  String endTime;
  final int initialduration;
  String timerstate = "TimerInitial";

  final Key key;
  TimerModel({
    @required this.id,
    @required this.timer,
    @required this.duration,
    @required this.initialduration,
    @required this.title,
    @required this.color,
    @required this.sound,
    @required this.timerstate,
    @required this.endTime,
    this.isDeleting = false,
  }) : key = ValueKey(id);

  TimerModel copyWith(
      {timer_type timer, int duration, String id, bool isDeleting}) {
    return TimerModel(
        title: title ?? this.title,
        color: color ?? this.color,
        id: id ?? this.id,
        duration: duration ?? this.duration,
        initialduration: initialduration ?? this.initialduration,
        timer: timer ?? this.timer,
        sound: sound ?? this.sound,
        isDeleting: isDeleting ?? this.isDeleting,
        timerstate: timerstate ?? this.timerstate,
        endTime: endTime ?? this.endTime);
  }

  Stream<int> tick({timer_type timer, delta = 0, @required starttime}) {
    return Stream.periodic(
        Duration(milliseconds: 100),
        (x) => timer == timer_type.stopwatch
            ? delta + starttime + x + 1
            : starttime - delta - x - 1);
  }

  @override
  String toString() =>
      'Item { id: $id, duration: $duration, timer type: $timer, timer state: $timerstate, initial duration: $initialduration }';

  factory TimerModel.fromJson(Map<String, dynamic> json) {
    // print('Json: ' + json.toString());
    return _$TimerModelFromJson(json); //.copyWith(duration: duration);
  }
  Map<String, dynamic> toJson() {
    // print('This: ' + this.toString());
    return _$TimerModelToJson(this);
  }
}
