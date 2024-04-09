part of 'spot_details_cubit.dart';

@freezed
class SpotDetailsAction with _$SpotDetailsAction {
  const factory SpotDetailsAction.spotDetailsActionInitial() = _SpotDetailsActionInitial;

  const factory SpotDetailsAction.spotRatingSnackBar({required String message}) = _SpotRatingSnackBar;
  const factory SpotDetailsAction.userAddedToSpot({required String message}) = _UserAddedToSpot;
  const factory SpotDetailsAction.listOfCommentDialogBox({required List<UserComment> listOfComments}) = _ListOfCommentsDialogBox;

}