import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'appstate_state.dart';

class AppStateCubit extends Cubit<AppStateState> {
  AppStateCubit() : super(AppStateInitial());

  Future<void> pausedApp() async {
    emit(AppStatePaused());
    // print('AppStatePaused');
  }

  Future<void> resumedApp() async {
    emit(AppStateResumed());

    // print('AppStateResumed');
  }

  Future<void> inactiveApp() async {
    emit(AppStateInactive());
    // print('AppStateInactive');
  }

  Future<void> detachedApp() async {
    emit(AppStatePaused());
    // print('AppStateDetached');
  }
}
