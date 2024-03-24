import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../../../user_relations/domain/usecases/get_user_curret_position_usecase.dart';

part 'add_spot_map_state.dart';
part 'add_spot_map_cubit.freezed.dart';

@injectable
class AddSpotMapCubit extends Cubit<AddSpotMapState> {
  final GetUserCurrentPositionUseCase getUserCurrentPositionUseCase;
  AddSpotMapCubit({required this.getUserCurrentPositionUseCase}) : super(const AddSpotMapState.initial());

  Future<void> initMap() async{
    emit(const AddSpotMapState.mapIsLoading());
    final result = await getUserCurrentPositionUseCase.call();
    result.fold((failure){
      emit(const AddSpotMapState.mapError(message: 'Unable to lad map'));
    }, (success){
      emit(AddSpotMapState.mapLoaded(spotPosition: success));
    });
  }

  Future<Position?> getUserPosition() async{
    final result = await getUserCurrentPositionUseCase.call();
    return result.fold((failure) async{
      return null;
    }, (success){
      return success;
    });
  }

  Future<void> geNewPosition(LatLng position) async{
    emit(AddSpotMapState.newPosition(spotPosition: position));
  }

}
