part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  final bool value;

  const DrawerState(this.value);

  @override
  List<Object> get props => [value];
}

class DrawerInitial extends DrawerState {
  const DrawerInitial(bool value) : super(value);

  @override
  List<Object> get props => [value];
}

class DrawerWakeLock extends DrawerState {
  final bool value;
  const DrawerWakeLock(this.value) : super(value);

  @override
  List<Object> get props => [value];
}
