import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

import '../../../user_relations/domain/usecases/get_user_curret_position_usecase.dart';
import '../../domain/usecases/show_skate_spots_usecase.dart';

part 'show_skate_spots_state.dart';
part 'show_skate_spots_cubit.freezed.dart';
@injectable
class ShowSkateSpotsCubit extends Cubit<ShowSkateSpotsState> {
  final ShowSkateSpotsUseCase showSkateSpotsUseCase;
  final GetUserCurrentPositionUseCase getUserCurrentPositionUseCase;
  ShowSkateSpotsCubit({required this.showSkateSpotsUseCase, required this.getUserCurrentPositionUseCase}) : super(const ShowSkateSpotsState.initial());

  StreamSubscription<List<SkateSpot>>? _streamSubscription;

  Future<void> showSkateSpotsInArea({required String distance}) async{
    final result = await getUserCurrentPositionUseCase();
    result.fold((failure){
    emit(const ShowSkateSpotsState.showSpotsPageError(message: 'Position worng'));
    }, (userPosition) async{
      final result = await showSkateSpotsUseCase(ShowSkateSpotsParams(distance: distance));
      result.fold((failure){
        emit(const ShowSkateSpotsState.showSpotsPageError(message: 'Unable to reach data'));
      }, (success){
        _streamSubscription = success.listen((event) {
          if(event.isEmpty){
            emit(const ShowSkateSpotsState.showSpotsPageEmpty(message: 'No spots right now'));
          }else{
            final List<SkateSpot> listOfSkateSpots = [];
            for(var skateSpot in event){
              final distanceToSpot = Geolocator.distanceBetween(
                  double.parse(skateSpot.spotLat),
                  double.parse(skateSpot.spotLang),
                  userPosition.latitude, userPosition.longitude);
              if(distanceToSpot <= double.parse(distance)){
                listOfSkateSpots.add(skateSpot);
              }
            }
            emit(ShowSkateSpotsState.showSpotsInitial(skateSpotsList: listOfSkateSpots));
          }
        });
      });
    });
  }

  @override
  Future<void> close() async{
    _streamSubscription?.cancel();
    super.close();
  }

}
