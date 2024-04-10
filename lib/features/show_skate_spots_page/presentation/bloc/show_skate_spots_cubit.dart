import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';

import '../../../user_relations/domain/usecases/get_user_by_id_usecase.dart';
import '../../../user_relations/domain/usecases/get_user_curret_position_usecase.dart';
import '../../domain/usecases/add_spot_to_favorites_usecase.dart';
import '../../domain/usecases/show_skate_spots_usecase.dart';

part 'show_skate_spots_state.dart';
part 'show_skate_spots_action.dart';
part 'show_skate_spots_cubit.freezed.dart';
@injectable
class ShowSkateSpotsCubit extends ActionCubit<ShowSkateSpotsState, ShowSkateSpotsAction> {
  final GetUserByIDUseCase getUserByIDUseCase;
  final ShowSkateSpotsUseCase showSkateSpotsUseCase;
  final GetUserCurrentPositionUseCase getUserCurrentPositionUseCase;
  final AddSpotToFavoritesUseCase addSpotToFavoritesUseCase;
  ShowSkateSpotsCubit({
    required this.showSkateSpotsUseCase,
    required this.getUserCurrentPositionUseCase,
    required this.getUserByIDUseCase,
    required this.addSpotToFavoritesUseCase,
  }) : super(const ShowSkateSpotsState.initial());

  StreamSubscription<List<SkateSpot>>? _streamSubscription;

  Future<void> showSkateSpotsInArea({required String distance, required String userID}) async{
    emit(const ShowSkateSpotsState.showSpotsPageLoading());
    if(USER_LOGGED_IN){
      final result = await getUserByIDUseCase(GetUserByIdParams(userID: userID));
      result.fold((failure){
        emit(const ShowSkateSpotsState.showSpotsPageError(message: 'Unable to reach data'));
      }, (user) async{
        showSpots(distance: distance, user: user);
      });

    }else{
      showSpots(distance: distance, user: MyUser.empty());
    }
  }

  Future<void> addSpotToFavorites({required String userID, required String spotID}) async{
    final result = await addSpotToFavoritesUseCase(AddSpotToFavoritesParams(spotID: spotID, userID: userID));
    result.fold((failure){
      dispatch(const ShowSkateSpotsAction.addSpotDialogBox(title: 'Add spot error', message: 'Unable to add new spot'));
    }, (success){
      dispatch(const ShowSkateSpotsAction.addSpotDialogBox(title: 'Spot added', message: 'Spot added successfully to favs.'));
      print('spot added to fav');
    });
  }


  Future<void> showSpots({required String distance, required MyUser user}) async{
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
            emit(ShowSkateSpotsState.showSpotsInitial(
              skateSpotsList: listOfSkateSpots,
              userPosition: userPosition,
              user: user,
            ));
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
