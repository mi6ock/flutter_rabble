import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hoge_state.freezed.dart';
part 'hoge_state.g.dart';

@freezed
abstract class HogeState with _$HogeState {
  const factory HogeState({
    @Default(0) int value,
    @Default("tom") String name,
    @Default("tomotom") String eat,
    @Default(9999) int count,
    List<_ModelKing> models,
  }) = _HogeState;

  factory HogeState.fromJson(Map<String, dynamic> json) =>
      _$HogeStateFromJson(json);
}

@freezed
abstract class _ModelKing with _$_ModelKing {
  const factory _ModelKing({
    String title,
    DateTime dateTime,
  }) = __ModelKing;

  factory _ModelKing.fromJson(Map<String, dynamic> json) =>
      _$_ModelKingFromJson(json);
}
