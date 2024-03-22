part of 'add_skate_spot_cubit.dart';

@freezed
class AddSkateSpotState with _$AddSkateSpotState {
  const factory AddSkateSpotState.initial() = _Initial;
  const factory AddSkateSpotState.addSkateSpotPageLoading() = _AddSkateSpotPageLoading;
  const factory AddSkateSpotState.addSkateSpotPageError({required String message}) = _AddSkateSpotPageError;
  const factory AddSkateSpotState.addSkateSpotPageLoaded({required bool userLoggedIn}) = _AddSkateSpotPageLoaded;

  const factory AddSkateSpotState.gallery({required List<String> gallery}) = _Gallery;

}
