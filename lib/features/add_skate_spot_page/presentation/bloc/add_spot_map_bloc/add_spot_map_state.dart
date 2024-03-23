part of 'add_spot_map_cubit.dart';

@freezed
class AddSpotMapState with _$AddSpotMapState {
  const factory AddSpotMapState.initial() = _Initial;
  const factory AddSpotMapState.mapIsLoading() = _MapIsLoading;
  const factory AddSpotMapState.mapError({required String message}) = _MapError;
  const factory AddSpotMapState.mapLoaded({required Position spotPosition}) = _MapLoaded;
}
