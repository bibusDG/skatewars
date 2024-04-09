// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserComment _$UserCommentFromJson(Map<String, dynamic> json) {
  return _UserComment.fromJson(json);
}

/// @nodoc
mixin _$UserComment {
  String get userName => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  String get creationDate => throw _privateConstructorUsedError;
  double get userRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCommentCopyWith<UserComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCommentCopyWith<$Res> {
  factory $UserCommentCopyWith(
          UserComment value, $Res Function(UserComment) then) =
      _$UserCommentCopyWithImpl<$Res, UserComment>;
  @useResult
  $Res call(
      {String userName, String comment, String creationDate, double userRate});
}

/// @nodoc
class _$UserCommentCopyWithImpl<$Res, $Val extends UserComment>
    implements $UserCommentCopyWith<$Res> {
  _$UserCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? comment = null,
    Object? creationDate = null,
    Object? userRate = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as String,
      userRate: null == userRate
          ? _value.userRate
          : userRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCommentImplCopyWith<$Res>
    implements $UserCommentCopyWith<$Res> {
  factory _$$UserCommentImplCopyWith(
          _$UserCommentImpl value, $Res Function(_$UserCommentImpl) then) =
      __$$UserCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName, String comment, String creationDate, double userRate});
}

/// @nodoc
class __$$UserCommentImplCopyWithImpl<$Res>
    extends _$UserCommentCopyWithImpl<$Res, _$UserCommentImpl>
    implements _$$UserCommentImplCopyWith<$Res> {
  __$$UserCommentImplCopyWithImpl(
      _$UserCommentImpl _value, $Res Function(_$UserCommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? comment = null,
    Object? creationDate = null,
    Object? userRate = null,
  }) {
    return _then(_$UserCommentImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as String,
      userRate: null == userRate
          ? _value.userRate
          : userRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCommentImpl implements _UserComment {
  const _$UserCommentImpl(
      {required this.userName,
      required this.comment,
      required this.creationDate,
      required this.userRate});

  factory _$UserCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCommentImplFromJson(json);

  @override
  final String userName;
  @override
  final String comment;
  @override
  final String creationDate;
  @override
  final double userRate;

  @override
  String toString() {
    return 'UserComment(userName: $userName, comment: $comment, creationDate: $creationDate, userRate: $userRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCommentImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.userRate, userRate) ||
                other.userRate == userRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userName, comment, creationDate, userRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCommentImplCopyWith<_$UserCommentImpl> get copyWith =>
      __$$UserCommentImplCopyWithImpl<_$UserCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCommentImplToJson(
      this,
    );
  }
}

abstract class _UserComment implements UserComment {
  const factory _UserComment(
      {required final String userName,
      required final String comment,
      required final String creationDate,
      required final double userRate}) = _$UserCommentImpl;

  factory _UserComment.fromJson(Map<String, dynamic> json) =
      _$UserCommentImpl.fromJson;

  @override
  String get userName;
  @override
  String get comment;
  @override
  String get creationDate;
  @override
  double get userRate;
  @override
  @JsonKey(ignore: true)
  _$$UserCommentImplCopyWith<_$UserCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
