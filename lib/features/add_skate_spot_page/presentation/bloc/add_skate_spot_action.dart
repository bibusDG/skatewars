part of 'add_skate_spot_cubit.dart';

@freezed
class AddSkateSpotAction with _$AddSkateSpotAction {
  const factory AddSkateSpotAction.initial() = _ActionInitial;

  const factory AddSkateSpotAction.inputFieldError({required String message}) = _InputFieldError;
}