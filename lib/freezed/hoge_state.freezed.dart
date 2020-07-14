// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'hoge_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

HogeState _$HogeStateFromJson(Map<String, dynamic> json) {
  return _HogeState.fromJson(json);
}

mixin _$HogeState {
  int get value;
  String get name;
  String get eat;
  int get count;
  List<_ModelKing> get models;

  HogeState copyWith(
      {int value, String name, String eat, int count, List<_ModelKing> models});

  Map<String, dynamic> toJson();
}

class _$HogeStateTearOff {
  const _$HogeStateTearOff();

  _HogeState call(
      {int value = 0,
      String name = 'tom',
      String eat = 'tomotom',
      int count = 9999,
      List<_ModelKing> models}) {
    return _HogeState(
      value: value,
      name: name,
      eat: eat,
      count: count,
      models: models,
    );
  }
}

const $HogeState = _$HogeStateTearOff();

@JsonSerializable()
class _$_HogeState with DiagnosticableTreeMixin implements _HogeState {
  const _$_HogeState(
      {this.value = 0,
      this.name = 'tom',
      this.eat = 'tomotom',
      this.count = 9999,
      this.models});

  factory _$_HogeState.fromJson(Map<String, dynamic> json) =>
      _$_$_HogeStateFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int value;
  @JsonKey(defaultValue: 'tom')
  @override
  final String name;
  @JsonKey(defaultValue: 'tomotom')
  @override
  final String eat;
  @JsonKey(defaultValue: 9999)
  @override
  final int count;
  @override
  final List<_ModelKing> models;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HogeState(value: $value, name: $name, eat: $eat, count: $count, models: $models)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HogeState'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('eat', eat))
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('models', models));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HogeState &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.eat, eat) ||
                const DeepCollectionEquality().equals(other.eat, eat)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.models, models) ||
                const DeepCollectionEquality().equals(other.models, models)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(eat) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(models);

  @override
  _$_HogeState copyWith({
    Object value = freezed,
    Object name = freezed,
    Object eat = freezed,
    Object count = freezed,
    Object models = freezed,
  }) {
    return _$_HogeState(
      value: value == freezed ? this.value : value as int,
      name: name == freezed ? this.name : name as String,
      eat: eat == freezed ? this.eat : eat as String,
      count: count == freezed ? this.count : count as int,
      models: models == freezed ? this.models : models as List<_ModelKing>,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HogeStateToJson(this);
  }
}

abstract class _HogeState implements HogeState {
  const factory _HogeState(
      {int value,
      String name,
      String eat,
      int count,
      List<_ModelKing> models}) = _$_HogeState;

  factory _HogeState.fromJson(Map<String, dynamic> json) =
      _$_HogeState.fromJson;

  @override
  int get value;
  @override
  String get name;
  @override
  String get eat;
  @override
  int get count;
  @override
  List<_ModelKing> get models;

  @override
  _HogeState copyWith(
      {int value, String name, String eat, int count, List<_ModelKing> models});
}

_ModelKing _$_ModelKingFromJson(Map<String, dynamic> json) {
  return __ModelKing.fromJson(json);
}

mixin _$_ModelKing {
  String get title;
  DateTime get dateTime;

  _ModelKing copyWith({String title, DateTime dateTime});

  Map<String, dynamic> toJson();
}

class _$_ModelKingTearOff {
  const _$_ModelKingTearOff();

  __ModelKing call({String title, DateTime dateTime}) {
    return __ModelKing(
      title: title,
      dateTime: dateTime,
    );
  }
}

const $_ModelKing = _$_ModelKingTearOff();

@JsonSerializable()
class _$__ModelKing with DiagnosticableTreeMixin implements __ModelKing {
  const _$__ModelKing({this.title, this.dateTime});

  factory _$__ModelKing.fromJson(Map<String, dynamic> json) =>
      _$_$__ModelKingFromJson(json);

  @override
  final String title;
  @override
  final DateTime dateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ModelKing(title: $title, dateTime: $dateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_ModelKing'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('dateTime', dateTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is __ModelKing &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.dateTime, dateTime) ||
                const DeepCollectionEquality()
                    .equals(other.dateTime, dateTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(dateTime);

  @override
  _$__ModelKing copyWith({
    Object title = freezed,
    Object dateTime = freezed,
  }) {
    return _$__ModelKing(
      title: title == freezed ? this.title : title as String,
      dateTime: dateTime == freezed ? this.dateTime : dateTime as DateTime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$__ModelKingToJson(this);
  }
}

abstract class __ModelKing implements _ModelKing {
  const factory __ModelKing({String title, DateTime dateTime}) = _$__ModelKing;

  factory __ModelKing.fromJson(Map<String, dynamic> json) =
      _$__ModelKing.fromJson;

  @override
  String get title;
  @override
  DateTime get dateTime;

  @override
  __ModelKing copyWith({String title, DateTime dateTime});
}
