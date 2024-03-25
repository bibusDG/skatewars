part of 'show_skate_spots_cubit.dart';

@freezed
class ShowSkateSpotsState with _$ShowSkateSpotsState {
  const factory ShowSkateSpotsState.initial() = _Initial;

  const factory ShowSkateSpotState.showSpotsInitial({required List<SkateSpot> skateSpotsList}) = _ShowSpotsInitial;
  const factory ShowSkateSpotState.showSpotsPageError({required String message}) = _ShowSpotsPageError;
  const factory ShowSkateSpotState.showSpotsPageLoading() = _ShowSpotsPageLoading;

}
