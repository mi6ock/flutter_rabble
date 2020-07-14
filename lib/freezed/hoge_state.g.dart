// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hoge_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HogeState _$_$_HogeStateFromJson(Map<String, dynamic> json) {
  return _$_HogeState(
    value: json['value'] as int ?? 0,
    name: json['name'] as String ?? 'tom',
    eat: json['eat'] as String ?? 'tomotom',
    count: json['count'] as int ?? 9999,
    models: (json['models'] as List)
        ?.map((e) =>
            e == null ? null : _ModelKing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_HogeStateToJson(_$_HogeState instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
      'eat': instance.eat,
      'count': instance.count,
      'models': instance.models,
    };

_$__ModelKing _$_$__ModelKingFromJson(Map<String, dynamic> json) {
  return _$__ModelKing(
    title: json['title'] as String,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
  );
}

Map<String, dynamic> _$_$__ModelKingToJson(_$__ModelKing instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
