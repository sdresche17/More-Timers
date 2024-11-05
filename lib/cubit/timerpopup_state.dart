part of 'timerpopup_cubit.dart';

abstract class TimerPopUpState extends Equatable {
  const TimerPopUpState();

  @override
  List<Object> get props => ['test'];
}

class TimerPopUpInitial extends TimerPopUpState {}

class TimerPopUpOpen extends TimerPopUpState {
  final Color color;
  const TimerPopUpOpen(this.color);
  @override
  List<Object> get props => [color, 'test'];
}

class TimeSet extends TimerPopUpState {
  final String _time;
  const TimeSet(this._time);
  @override
  List<Object> get props => [_time];
}

class ColorSet extends TimerPopUpState {
  final Color _color;
  const ColorSet(this._color);
  @override
  List<Object> get props => [_color];
}

class TitleSet extends TimerPopUpState {
  final String _title;
  const TitleSet(this._title);
  @override
  List<Object> get props => [_title];
}

class SoundSet extends TimerPopUpState {
  final String _sound;
  const SoundSet(this._sound);
  @override
  List<Object> get props => [_sound];
}

class Closed extends TimerPopUpState {}
