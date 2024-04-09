part of 'spot_details_cubit.dart';

@freezed
class SpotDetailsAction with _$SpotDetailsAction {
  const factory SpotDetailsAction.spotDetailsActionInitial() = _SpotDetailsActionInitial;

  const factory SpotDetailsAction.spotRatingSnackBar({required String message}) = _SpotRatingSnackBar;

}