import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  final int duration;

  const TimerStarted({@required this.duration});

  @override
  String toString() => "TimerStarted { duration: $duration }";
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerDestroyed extends TimerEvent {}

class TimerUpdated extends TimerEvent {
  final int delta;
  final int duration;
  const TimerUpdated({@required this.delta, @required this.duration});
  @override
  List<Object> get props => [duration, delta];

  @override
  String toString() => "TimerUpdated { duration: $duration, delta: $delta}";
}

class TimerTicked extends TimerEvent {
  final int duration;

  const TimerTicked({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "TimerTicked { duration: $duration }";
}
