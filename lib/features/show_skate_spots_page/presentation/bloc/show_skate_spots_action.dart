part of 'show_skate_spots_cubit.dart';

@freezed
class ShowSkateSpotsAction with _$ShowSkateSpotsAction {
  const factory ShowSkateSpotsAction.actionSpotsInitial() = _ActionSpotsInitial;

  const factory ShowSkateSpotsAction.addSpotDialogBox({required String title, required String message}) = _AddSpotDialogBox;

}
