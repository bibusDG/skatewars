part of 'spot_details_cubit.dart';

@freezed
class SpotDetailsState with _$SpotDetailsState {
  const factory SpotDetailsState.initial() = _Initial;

  const factory SpotDetailsState.spotDetailsPageLoaded({required SkateSpot skateSpot, required List<MyUser> riders}) = _SpotDetailsPageLoaded;
  const factory SpotDetailsState.spotDetailsPageLoading() = _SpotDetailsPageLoading;
  const factory SpotDetailsState.spotDetailsPageError({required String message}) = _SpotDetailsPageError;

}
