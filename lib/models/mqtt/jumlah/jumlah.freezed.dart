// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jumlah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Jumlah _$JumlahFromJson(Map<String, dynamic> json) {
  return _Jumlah.fromJson(json);
}

/// @nodoc
mixin _$Jumlah {
  String? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JumlahCopyWith<Jumlah> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JumlahCopyWith<$Res> {
  factory $JumlahCopyWith(Jumlah value, $Res Function(Jumlah) then) =
      _$JumlahCopyWithImpl<$Res, Jumlah>;
  @useResult
  $Res call({String? data});
}

/// @nodoc
class _$JumlahCopyWithImpl<$Res, $Val extends Jumlah>
    implements $JumlahCopyWith<$Res> {
  _$JumlahCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JumlahImplCopyWith<$Res> implements $JumlahCopyWith<$Res> {
  factory _$$JumlahImplCopyWith(
          _$JumlahImpl value, $Res Function(_$JumlahImpl) then) =
      __$$JumlahImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? data});
}

/// @nodoc
class __$$JumlahImplCopyWithImpl<$Res>
    extends _$JumlahCopyWithImpl<$Res, _$JumlahImpl>
    implements _$$JumlahImplCopyWith<$Res> {
  __$$JumlahImplCopyWithImpl(
      _$JumlahImpl _value, $Res Function(_$JumlahImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$JumlahImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JumlahImpl implements _Jumlah {
  _$JumlahImpl({this.data});

  factory _$JumlahImpl.fromJson(Map<String, dynamic> json) =>
      _$$JumlahImplFromJson(json);

  @override
  final String? data;

  @override
  String toString() {
    return 'Jumlah(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JumlahImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JumlahImplCopyWith<_$JumlahImpl> get copyWith =>
      __$$JumlahImplCopyWithImpl<_$JumlahImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JumlahImplToJson(
      this,
    );
  }
}

abstract class _Jumlah implements Jumlah {
  factory _Jumlah({final String? data}) = _$JumlahImpl;

  factory _Jumlah.fromJson(Map<String, dynamic> json) = _$JumlahImpl.fromJson;

  @override
  String? get data;
  @override
  @JsonKey(ignore: true)
  _$$JumlahImplCopyWith<_$JumlahImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
