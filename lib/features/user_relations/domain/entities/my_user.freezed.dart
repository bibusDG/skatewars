// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyUser _$MyUserFromJson(Map<String, dynamic> json) {
  return _MyUser.fromJson(json);
}

/// @nodoc
mixin _$MyUser {
  String get userEmail => throw _privateConstructorUsedError;
  String get userPassword => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userSureName => throw _privateConstructorUsedError;
  String get userAvatar => throw _privateConstructorUsedError;
  String get userMobileToken => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyUserCopyWith<MyUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyUserCopyWith<$Res> {
  factory $MyUserCopyWith(MyUser value, $Res Function(MyUser) then) =
      _$MyUserCopyWithImpl<$Res, MyUser>;
  @useResult
  $Res call(
      {String userEmail,
      String userPassword,
      String userName,
      String userSureName,
      String userAvatar,
      String userMobileToken,
      String userID});
}

/// @nodoc
class _$MyUserCopyWithImpl<$Res, $Val extends MyUser>
    implements $MyUserCopyWith<$Res> {
  _$MyUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEmail = null,
    Object? userPassword = null,
    Object? userName = null,
    Object? userSureName = null,
    Object? userAvatar = null,
    Object? userMobileToken = null,
    Object? userID = null,
  }) {
    return _then(_value.copyWith(
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userPassword: null == userPassword
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userSureName: null == userSureName
          ? _value.userSureName
          : userSureName // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: null == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      userMobileToken: null == userMobileToken
          ? _value.userMobileToken
          : userMobileToken // ignore: cast_nullable_to_non_nullable
              as String,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyUserImplCopyWith<$Res> implements $MyUserCopyWith<$Res> {
  factory _$$MyUserImplCopyWith(
          _$MyUserImpl value, $Res Function(_$MyUserImpl) then) =
      __$$MyUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userEmail,
      String userPassword,
      String userName,
      String userSureName,
      String userAvatar,
      String userMobileToken,
      String userID});
}

/// @nodoc
class __$$MyUserImplCopyWithImpl<$Res>
    extends _$MyUserCopyWithImpl<$Res, _$MyUserImpl>
    implements _$$MyUserImplCopyWith<$Res> {
  __$$MyUserImplCopyWithImpl(
      _$MyUserImpl _value, $Res Function(_$MyUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEmail = null,
    Object? userPassword = null,
    Object? userName = null,
    Object? userSureName = null,
    Object? userAvatar = null,
    Object? userMobileToken = null,
    Object? userID = null,
  }) {
    return _then(_$MyUserImpl(
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userPassword: null == userPassword
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userSureName: null == userSureName
          ? _value.userSureName
          : userSureName // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: null == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      userMobileToken: null == userMobileToken
          ? _value.userMobileToken
          : userMobileToken // ignore: cast_nullable_to_non_nullable
              as String,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyUserImpl implements _MyUser {
  const _$MyUserImpl(
      {required this.userEmail,
      required this.userPassword,
      required this.userName,
      required this.userSureName,
      required this.userAvatar,
      required this.userMobileToken,
      required this.userID});

  factory _$MyUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyUserImplFromJson(json);

  @override
  final String userEmail;
  @override
  final String userPassword;
  @override
  final String userName;
  @override
  final String userSureName;
  @override
  final String userAvatar;
  @override
  final String userMobileToken;
  @override
  final String userID;

  @override
  String toString() {
    return 'MyUser(userEmail: $userEmail, userPassword: $userPassword, userName: $userName, userSureName: $userSureName, userAvatar: $userAvatar, userMobileToken: $userMobileToken, userID: $userID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyUserImpl &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userPassword, userPassword) ||
                other.userPassword == userPassword) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userSureName, userSureName) ||
                other.userSureName == userSureName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.userMobileToken, userMobileToken) ||
                other.userMobileToken == userMobileToken) &&
            (identical(other.userID, userID) || other.userID == userID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userEmail, userPassword,
      userName, userSureName, userAvatar, userMobileToken, userID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyUserImplCopyWith<_$MyUserImpl> get copyWith =>
      __$$MyUserImplCopyWithImpl<_$MyUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyUserImplToJson(
      this,
    );
  }
}

abstract class _MyUser implements MyUser {
  const factory _MyUser(
      {required final String userEmail,
      required final String userPassword,
      required final String userName,
      required final String userSureName,
      required final String userAvatar,
      required final String userMobileToken,
      required final String userID}) = _$MyUserImpl;

  factory _MyUser.fromJson(Map<String, dynamic> json) = _$MyUserImpl.fromJson;

  @override
  String get userEmail;
  @override
  String get userPassword;
  @override
  String get userName;
  @override
  String get userSureName;
  @override
  String get userAvatar;
  @override
  String get userMobileToken;
  @override
  String get userID;
  @override
  @JsonKey(ignore: true)
  _$$MyUserImplCopyWith<_$MyUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
