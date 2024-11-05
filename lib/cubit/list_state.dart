// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:flutter/material.dart';
// import 'package:moretimers/models/repository.dart';

part of 'list_cubit.dart';

abstract class ListState extends Equatable {
  const ListState();
  @override
  List<Object> get props => [];
}

class Loading extends ListState {}

class Update extends ListState {}

class Loaded extends ListState {
  final Repository repo;
  const Loaded({@required this.repo});
  @override
  List<Object> get props => [repo];
  @override
  String toString() => 'Loaded { timers: $repo }';
}

class Failure extends ListState {}
