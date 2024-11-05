import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:moretimers/models/timer.dart';
import 'package:json_annotation/json_annotation.dart';
part 'repository.g.dart';

@JsonSerializable(explicitToJson: true)
class Repository extends Equatable {
  final List<TimerModel> timers;
  const Repository({
    this.timers,
  });

  Future<List<TimerModel>> fetchItems() async {
    return List.of(timers);
  }

  void addTimer(TimerModel timer) {
    timers.add(timer);
  }

  void deleteTimer(id) {
    timers.removeWhere((item) => item.id == id);
  }

  Stream<String> deleteItem(String id) async* {
    yield id;
  }

  Stream<String> addItem(String id) async* {
    yield id;
  }

  @override
  List<Object> get props => [timers];
  @override
  String toString() => '{ timers: $timers}';

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}
