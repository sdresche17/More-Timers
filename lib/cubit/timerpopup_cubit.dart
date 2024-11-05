import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moretimers/models/timer.dart';
import 'package:moretimers/models/soundmap.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
part 'timerpopup_state.dart';

class TimerpopupCubit extends Cubit<TimerPopUpState> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int time = 600;
  String timedisplay = '00:01:00';
  Color color = Colors.white;
  String title;
  String sound = soundList.keys.first;
  TimerpopupCubit() : super(TimerPopUpInitial());

  Future<void> setTimerTime(String _time, timer_type timer) async {
    timedisplay = _time;
    if (timer == timer_type.timer) {
      time = int.parse(_time.split(':')[0]) * 3600 +
          int.parse(_time.split(':')[1]) * 60 +
          int.parse(_time.split(':')[2]);
      time = time * 10;
    }
    print('time: ' + time.toString());
    emit(TimeSet(_time));
  }

  Future<void> setTimerColor(Color _color) async {
    color = _color;
    emit(ColorSet(_color));
  }

  Future<void> setTimerTitle(String _title) async {
    title = _title;
    emit(TitleSet(_title));
  }

  Future<void> pauseTimerSound() async {
    if (assetsAudioPlayer.isPlaying.value) {
      assetsAudioPlayer.pause();
    }
  }

  Future<void> setTimerSound(String _sound) async {
    sound = _sound;
    print('Sound: ' + _sound);
    assetsAudioPlayer.open(
      Audio(soundList[_sound]),
    );
    emit(TitleSet(_sound));
  }
}
