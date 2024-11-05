import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moretimers/models/repository.dart';
import 'package:flutter/material.dart';
import 'package:moretimers/models/timer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:moretimers/models/soundmap.dart';
import 'package:moretimers/models/uniqueid.dart';
import 'package:equatable/equatable.dart';

part 'list_state.dart';

class ListCubit extends HydratedCubit<ListState> {
  Repository repo;
  ListCubit({this.repo}) : super(Loading());

  Future<void> fetch() async {
    final listState = state;
    if (listState.props.length > 0) {
      repo = listState.props[0];

      emit(Loaded(repo: repo));
    } else {
      repo = _generateRepo();
      emit(Loaded(repo: repo));
    }
  }

  Future<void> update() async {
    emit(Update());
    _updated();
  }

  Future<void> _updated() async {
    emit(Loaded(repo: repo));
  }

  Future<void> delete(event) async {
    emit(Loading());
    repo.deleteTimer(event);
    repo.deleteItem(event).listen((id) {
      _deleted();
    });
  }

  Future<void> _deleted() async {
    emit(Loaded(repo: repo));
  }

  Future<void> add(event) async {
    final listState = state;
    if (listState is Loaded) {
      emit(Loading());
      repo.addItem(event.id).listen((id) {
        added(event);
      });
    }
  }

  Future<void> added(event) async {
    final listState = state;

    repo.addTimer(TimerModel(
        title: event.title,
        sound: event.sound,
        color: event.color.toString(),
        id: event.id,
        timer: event.timer,
        duration: event.duration,
        timerstate: event.timerstate,
        initialduration: event.duration,
        endTime: event.endTime));
    emit(Loaded(repo: repo));
  }

  @override
  ListState fromJson(Map<String, dynamic> json) {
    final repo = Repository.fromJson(json);
    return Loaded(repo: repo);
  }

  @override
  Map<String, dynamic> toJson(ListState state) {
    if (state is Loaded) {
      return state.repo.toJson();
    } else {
      return null;
    }
  }

  Repository _generateRepo() {
    String id = uniqueid();
    repo = Repository(timers: [
      TimerModel(
          id: id,
          timer: timer_type.timer,
          duration: 100,
          initialduration: 100,
          title: 'Your First Timer!',
          color: Colors.white.toString(),
          sound: soundList.keys.toList()[0],
          timerstate: 'TimerInitial',
          endTime: DateTime.now().toString()),
    ]);
    return repo;
  }
}
