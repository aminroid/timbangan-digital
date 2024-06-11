import 'package:freezed_annotation/freezed_annotation.dart';

part 'jumlah.freezed.dart';
part 'jumlah.g.dart';

@freezed
class Jumlah with _$Jumlah {
  factory Jumlah({
    String? data,
  }) = _Jumlah;

  factory Jumlah.fromJson(Map<String, dynamic> json) => _$JumlahFromJson(json);
}
