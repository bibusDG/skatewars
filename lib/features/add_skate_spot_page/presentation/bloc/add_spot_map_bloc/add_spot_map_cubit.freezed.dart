// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_spot_map_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddSpotMapState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() mapIsLoading,
    required TResult Function(String message) mapError,
    required TResult Function(Position spotPosition) mapLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? mapIsLoading,
    TResult? Function(String message)? mapError,
    TResult? Function(Position spotPosition)? mapLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? mapIsLoading,
    TResult Function(String message)? mapError,
    TResult Function(Position spotPosition)? mapLoaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_MapIsLoading value) mapIsLoading,
    required TResult Function(_MapError value) mapError,
    required TResult Function(_MapLoaded value) mapLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_MapIsLoading value)? mapIsLoading,
    TResult? Function(_MapError value)? mapError,
    TResult? Function(_MapLoaded value)? mapLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_MapIsLoading value)? mapIsLoading,
    TResult Function(_MapError value)? mapError,
    TResult Function(_MapLoaded value)? mapLoaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddSpotMapStateCopyWith<$Res> {
  factory $AddSpotMapStateCopyWith(
          AddSpotMapState value, $Res Function(AddSpotMapState) then) =
      _$AddSpotMapStateCopyWithImpl<$Res, AddSpotMapState>;
}

/// @nodoc
class _$AddSpotMapStateCopyWithImpl<$Res, $Val extends AddSpotMapState>
    implements $AddSpotMapStateCopyWith<$Res> {
  _$AddSpotMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AddSpotMapStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AddSpotMapState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() mapIsLoading,
    required TResult Function(String message) mapError,
    required TResult Function(Position spotPosition) mapLoaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? mapIsLoading,
    TResult? Function(String message)? mapError,
    TResult? Function(Position spotPosition)? mapLoaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? mapIsLoading,
    TResult Function(String message)? mapError,
    TResult Function(Position spotPosition)? mapLoaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_MapIsLoading value) mapIsLoading,
    required TResult Function(_MapError value) mapError,
    required TResult Function(_MapLoaded value) mapLoaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_MapIsLoading value)? mapIsLoading,
    TResult? Function(_MapError value)? mapError,
    TResult? Function(_MapLoaded value)? mapLoaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_MapIsLoading value)? mapIsLoading,
    TResult Function(_MapError value)? mapError,
    TResult Function(_MapLoaded value)? mapLoaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AddSpotMapState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$MapIsLoadingImplCopyWith<$Res> {
  factory _$$MapIsLoadingImplCopyWith(
          _$MapIsLoadingImpl value, $Res Function(_$MapIsLoadingImpl) then) =
      __$$MapIsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MapIsLoadingImplCopyWithImpl<$Res>
    extends _$AddSpotMapStateCopyWithImpl<$Res, _$MapIsLoadingImpl>
    implements _$$MapIsLoadingImplCopyWith<$Res> {
  __$$MapIsLoadingImplCopyWithImpl(
      _$MapIsLoadingImpl _value, $Res Function(_$MapIsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MapIsLoadingImpl implements _MapIsLoading {
  const _$MapIsLoadingImpl();

  @override
  String toString() {
    return 'AddSpotMapState.mapIsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MapIsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() mapIsLoading,
    required TResult Function(String message) mapError,
    required TResult Function(Position spotPosition) mapLoaded,
  }) {
    return mapIsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? mapIsLoading,
    TResult? Function(String message)? mapError,
    TResult? Function(Position spotPosition)? mapLoaded,
  }) {
    return mapIsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? mapIsLoading,
    TResult Function(String message)? mapError,
    TResult Function(Position spotPosition)? mapLoaded,
    required TResult orElse(),
  }) {
    if (mapIsLoading != null) {
      return mapIsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_MapIsLoading value) mapIsLoading,
    required TResult Function(_MapError value) mapError,
    required TResult Function(_MapLoaded value) mapLoaded,
  }) {
    return mapIsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_MapIsLoading value)? mapIsLoading,
    TResult? Function(_MapError value)? mapError,
    TResult? Function(_MapLoaded value)? mapLoaded,
  }) {
    return mapIsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_MapIsLoading value)? mapIsLoading,
    TResult Function(_MapError value)? mapError,
    TResult Function(_MapLoaded value)? mapLoaded,
    required TResult orElse(),
  }) {
    if (mapIsLoading != null) {
      return mapIsLoading(this);
    }
    return orElse();
  }
}

abstract class _MapIsLoading implements AddSpotMapState {
  const factory _MapIsLoading() = _$MapIsLoadingImpl;
}

/// @nodoc
abstract class _$$MapErrorImplCopyWith<$Res> {
  factory _$$MapErrorImplCopyWith(
          _$MapErrorImpl value, $Res Function(_$MapErrorImpl) then) =
      __$$MapErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MapErrorImplCopyWithImpl<$Res>
    extends _$AddSpotMapStateCopyWithImpl<$Res, _$MapErrorImpl>
    implements _$$MapErrorImplCopyWith<$Res> {
  __$$MapErrorImplCopyWithImpl(
      _$MapErrorImpl _value, $Res Function(_$MapErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MapErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MapErrorImpl implements _MapError {
  const _$MapErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AddSpotMapState.mapError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapErrorImplCopyWith<_$MapErrorImpl> get copyWith =>
      __$$MapErrorImplCopyWithImpl<_$MapErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() mapIsLoading,
    required TResult Function(String message) mapError,
    required TResult Function(Position spotPosition) mapLoaded,
  }) {
    return mapError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? mapIsLoading,
    TResult? Function(String message)? mapError,
    TResult? Function(Position spotPosition)? mapLoaded,
  }) {
    return mapError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? mapIsLoading,
    TResult Function(String message)? mapError,
    TResult Function(Position spotPosition)? mapLoaded,
    required TResult orElse(),
  }) {
    if (mapError != null) {
      return mapError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_MapIsLoading value) mapIsLoading,
    required TResult Function(_MapError value) mapError,
    required TResult Function(_MapLoaded value) mapLoaded,
  }) {
    return mapError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_MapIsLoading value)? mapIsLoading,
    TResult? Function(_MapError value)? mapError,
    TResult? Function(_MapLoaded value)? mapLoaded,
  }) {
    return mapError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_MapIsLoading value)? mapIsLoading,
    TResult Function(_MapError value)? mapError,
    TResult Function(_MapLoaded value)? mapLoaded,
    required TResult orElse(),
  }) {
    if (mapError != null) {
      return mapError(this);
    }
    return orElse();
  }
}

abstract class _MapError implements AddSpotMapState {
  const factory _MapError({required final String message}) = _$MapErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$MapErrorImplCopyWith<_$MapErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MapLoadedImplCopyWith<$Res> {
  factory _$$MapLoadedImplCopyWith(
          _$MapLoadedImpl value, $Res Function(_$MapLoadedImpl) then) =
      __$$MapLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Position spotPosition});
}

/// @nodoc
class __$$MapLoadedImplCopyWithImpl<$Res>
    extends _$AddSpotMapStateCopyWithImpl<$Res, _$MapLoadedImpl>
    implements _$$MapLoadedImplCopyWith<$Res> {
  __$$MapLoadedImplCopyWithImpl(
      _$MapLoadedImpl _value, $Res Function(_$MapLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spotPosition = null,
  }) {
    return _then(_$MapLoadedImpl(
      spotPosition: null == spotPosition
          ? _value.spotPosition
          : spotPosition // ignore: cast_nullable_to_non_nullable
              as Position,
    ));
  }
}

/// @nodoc

class _$MapLoadedImpl implements _MapLoaded {
  const _$MapLoadedImpl({required this.spotPosition});

  @override
  final Position spotPosition;

  @override
  String toString() {
    return 'AddSpotMapState.mapLoaded(spotPosition: $spotPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapLoadedImpl &&
            (identical(other.spotPosition, spotPosition) ||
                other.spotPosition == spotPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spotPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapLoadedImplCopyWith<_$MapLoadedImpl> get copyWith =>
      __$$MapLoadedImplCopyWithImpl<_$MapLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() mapIsLoading,
    required TResult Function(String message) mapError,
    required TResult Function(Position spotPosition) mapLoaded,
  }) {
    return mapLoaded(spotPosition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? mapIsLoading,
    TResult? Function(String message)? mapError,
    TResult? Function(Position spotPosition)? mapLoaded,
  }) {
    return mapLoaded?.call(spotPosition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? mapIsLoading,
    TResult Function(String message)? mapError,
    TResult Function(Position spotPosition)? mapLoaded,
    required TResult orElse(),
  }) {
    if (mapLoaded != null) {
      return mapLoaded(spotPosition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_MapIsLoading value) mapIsLoading,
    required TResult Function(_MapError value) mapError,
    required TResult Function(_MapLoaded value) mapLoaded,
  }) {
    return mapLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_MapIsLoading value)? mapIsLoading,
    TResult? Function(_MapError value)? mapError,
    TResult? Function(_MapLoaded value)? mapLoaded,
  }) {
    return mapLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_MapIsLoading value)? mapIsLoading,
    TResult Function(_MapError value)? mapError,
    TResult Function(_MapLoaded value)? mapLoaded,
    required TResult orElse(),
  }) {
    if (mapLoaded != null) {
      return mapLoaded(this);
    }
    return orElse();
  }
}

abstract class _MapLoaded implements AddSpotMapState {
  const factory _MapLoaded({required final Position spotPosition}) =
      _$MapLoadedImpl;

  Position get spotPosition;
  @JsonKey(ignore: true)
  _$$MapLoadedImplCopyWith<_$MapLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
