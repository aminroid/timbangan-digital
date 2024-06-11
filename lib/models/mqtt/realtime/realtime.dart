import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime.freezed.dart';
part 'realtime.g.dart';

@freezed
class Realtime with _$Realtime {
  factory Realtime({
    String? data,
  }) = _Realtime;

  factory Realtime.fromJson(Map<String, dynamic> json) =>
      _$RealtimeFromJson(json);
}
