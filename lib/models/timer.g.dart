// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimerModel _$TimerModelFromJson(Map<String, dynamic> json) {
  return TimerModel(
    id: json['id'] as String,
    timer: _$enumDecodeNullable(_$timer_typeEnumMap, json['timer']),
    duration: json['duration'] as int,
    initialduration: json['initialduration'] as int,
    title: json['title'] as String,
    color: json['color'] as String,
    sound: json['sound'] as String,
    timerstate: json['timerstate'] as String,
    endTime: json['endTime'] as String,
    isDeleting: json['isDeleting'] as bool,
  );
}

Map<String, dynamic> _$TimerModelToJson(TimerModel instance) =>
    <String, dynamic>{
      'timer': _$timer_typeEnumMap[instance.timer],
      'duration': instance.duration,
      'id': instance.id,
      'isDeleting': instance.isDeleting,
      'color': instance.color,
      'title': instance.title,
      'sound': instance.sound,
      'endTime': instance.endTime,
      'initialduration': instance.initialduration,
      'timerstate': instance.timerstate,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$timer_typeEnumMap = {
  timer_type.stopwatch: 'stopwatch',
  timer_type.timer: 'timer',
};
