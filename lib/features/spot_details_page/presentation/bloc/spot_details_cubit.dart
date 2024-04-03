import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

import '../../domain/usecases/add_user_to_spot_usecase.dart';
import '../../domain/usecases/get_spot_details_usecase.dart';
import '../../domain/usecases/remove_user_from_spot_usecase.dart';

part 'spot_details_state.dart';
part 'spot_details_cubit.freezed.dart';
@injectable
class SpotDetailsCubit extends Cubit<SpotDetailsState> {
  final GetSpotDetailsUseCase getSpotDetailsUseCase;
  final AddUserToSpotUseCase addUserToSpotUseCase;
  final RemoveUserFromSpotUseCase removeUserFromSpotUseCase;
  SpotDetailsCubit({required this.getSpotDetailsUseCase,
    required this.removeUserFromSpotUseCase,
    required this.addUserToSpotUseCase,
  }) : super(const SpotDetailsState.initial());

  StreamSubscription<SkateSpot>? _streamSubscription;

  Future<void> initSpotDetailPage({required String spotID}) async{
    final result = await getSpotDetailsUseCase(GetSpotDetailsParams(spotID: spotID));
    result.fold((failure){
      emit(const SpotDetailsState.spotDetailsPageError(message: 'Upps...Something went wrong'));
    }, (success){
      _streamSubscription = success.listen((event) {
        emit(SpotDetailsState.spotDetailsPageLoaded(skateSpot: event));
      });
    });
  }


  Future<void> addUserToSpot({required String spotID, required String userID}) async{
    final result = await addUserToSpotUseCase(AddUserToSpotParams(spotID: spotID, userID: userID));
    result.fold((failure){
      print('user not added');
    }, (success){
      print('userAdded to spot');
    });
  }

  Future<void> removeUserFromSpot({required String userID, required String spotID}) async{
    final result = await removeUserFromSpotUseCase(RemoveUserFromSpotParams(spotID: spotID, userID: userID));
    result.fold((failure){
      print('cant remove user from spot');
    }, (success){
      print('user removed from spot');
    });
  }

  @override
  Future<void> close() async{
    _streamSubscription?.cancel();
    super.close();
  }

}
