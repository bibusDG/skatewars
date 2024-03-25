import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

import '../../domain/usecases/show_skate_spots_usecase.dart';

part 'show_skate_spots_state.dart';
part 'show_skate_spots_cubit.freezed.dart';

class ShowSkateSpotsCubit extends Cubit<ShowSkateSpotsState> {
  final ShowSkateSpotsUseCase showSkateSpotsUseCase;
  ShowSkateSpotsCubit({required this.showSkateSpotsUseCase}) : super(const ShowSkateSpotsState.initial());

  StreamSubscription<List<SkateSpot>>? _streamSubscription;

  Future<void> showSkateSpotsInArea({required Position userPosition, required String distance}) async{
    final result = await showSkateSpotsUseCase(ShowSkateSpotsParams(userPosition: userPosition, distance: distance));
    result.fold((failure){

    }, (success){
      _streamSubscription = success.listen((event) {
        final List<SkateSpot> listOfSkateSpots = [];
        for(var skateSpot in event){
          final distance = Geolocator.distanceBetween(
              double.parse(skateSpot.spotLat),
              double.parse(skateSpot.spotLang),
              userPosition.latitude, userPosition.longitude);
          if(distance <= 20000){
            listOfSkateSpots.add(skateSpot);
          }
        }
      });
    });
  }

  @override
  Future<void> close() async{
    _streamSubscription?.cancel();
    super.close();
  }

}
