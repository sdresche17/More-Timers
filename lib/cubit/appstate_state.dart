part of 'appstate_cubit.dart';

abstract class AppStateState extends Equatable {
  const AppStateState();

  @override
  List<Object> get props => [];
}

class AppStateInitial extends AppStateState {}

class AppStateResumed extends AppStateState {}

class AppStatePaused extends AppStateState {}

class AppStateInactive extends AppStateState {}

class AppStateDetatched extends AppStateState {}
