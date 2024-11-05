import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  bool value;
  DrawerCubit({@required value}) : super(DrawerInitial(value));

  Future<void> changeWakeLock(bool _value) async {
    if (_value) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
    emit(DrawerWakeLock(_value));
  }
}
