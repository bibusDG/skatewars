part of 'show_skate_spots_cubit.dart';

@freezed
class ShowSkateSpotsState with _$ShowSkateSpotsState {
  const factory ShowSkateSpotsState.initial() = _Initial;

  const factory ShowSkateSpotsState.showSpotsInitial({
    required List<SkateSpot> skateSpotsList,
    required Position userPosition,
    required MyUser user,
  }) = _ShowSpotsInitial;
  const factory ShowSkateSpotsState.showSpotsPageError({required String message}) = _ShowSpotsPageError;
  const factory ShowSkateSpotsState.showSpotsPageLoading() = _ShowSpotsPageLoading;
  const factory ShowSkateSpotsState.showSpotsPageEmpty({required String message}) = _ShowSpotsPageEmpty;

}
