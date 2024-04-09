import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/spot_details_page/domain/usecases/get_comment_by_id_usecase.dart';
import 'package:skatewars/features/spot_details_page/domain/usecases/rate_spot_usecase.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';

import '../../../user_relations/domain/usecases/get_user_by_id_usecase.dart';
import '../../domain/entities/user_comment.dart';
import '../../domain/usecases/add_user_to_spot_usecase.dart';
import '../../domain/usecases/get_spot_details_usecase.dart';
import '../../domain/usecases/remove_user_from_spot_usecase.dart';

part 'spot_details_state.dart';
part 'spot_details_action.dart';
part 'spot_details_cubit.freezed.dart';

@injectable
class SpotDetailsCubit extends ActionCubit<SpotDetailsState, SpotDetailsAction> {
  final GetCommentByIdUseCase getCommentByIdUseCase;
  final RateSpotUseCase rateSpotUseCase;
  final GetSpotDetailsUseCase getSpotDetailsUseCase;
  final AddUserToSpotUseCase addUserToSpotUseCase;
  final RemoveUserFromSpotUseCase removeUserFromSpotUseCase;
  final GetUserByIDUseCase getUserByIDUseCase;
  SpotDetailsCubit({required this.getSpotDetailsUseCase,
    required this.getCommentByIdUseCase,
    required this.rateSpotUseCase,
    required this.removeUserFromSpotUseCase,
    required this.addUserToSpotUseCase,
    required this.getUserByIDUseCase,
  }) : super(const SpotDetailsState.initial());

  StreamSubscription<SkateSpot>? _streamSubscription;

  Future<void> initSpotDetailPage({required String spotID, required String uid}) async{
    if(USER_LOGGED_IN){
      final result = await getUserByIDUseCase(GetUserByIdParams(userID: uid));
      result.fold((failure){
        emit(const SpotDetailsState.spotDetailsPageError(message: 'Upps...Something went wrong'));
      }, (existingUser) async{
        getSpot(spotID: spotID, existingUser: existingUser);
      });
    }else{
      getSpot(spotID: spotID, existingUser: MyUser.empty());
    }

  }

  Future<void> getSpot({required String spotID, required MyUser existingUser}) async{
    final result = await getSpotDetailsUseCase(GetSpotDetailsParams(spotID: spotID));
    result.fold((failure){
      emit(const SpotDetailsState.spotDetailsPageError(message: 'Upps...Something went wrong'));
    }, (success) {
      _streamSubscription = success.listen((event) async{
        List<MyUser> riders = [];
        for(var uid in event.spotRiders){
          final result = await getUserByIDUseCase(GetUserByIdParams(userID: uid));
          result.fold((failure){
            null;
          }, (user){
            riders.add(user);
          });
        }
        emit(SpotDetailsState.spotDetailsPageLoaded(skateSpot: event, riders: riders, existingUser: existingUser));
      });
    });
  }


  Future<void> addUserToSpot({required String spotID, required String userID}) async{
    final result = await addUserToSpotUseCase(AddUserToSpotParams(spotID: spotID, userID: userID));
    result.fold((failure){
      dispatch(const SpotDetailsAction.userAddedToSpot(message: 'Unable to add user to spot'));
    }, (success){
      dispatch(const SpotDetailsAction.userAddedToSpot(message: 'Since now, you are riding here'));
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

  Future<void> rateSpot({
    required String comment,
    required double userRate,
    required String userName,
    required String spotID,
    required String creationDate,
  }) async{
    final result = await rateSpotUseCase(RateSpotParams(
        spotID: spotID,
        userName: userName,
        comment: comment,
        creationDate: creationDate,
        userRate: userRate));
    result.fold((failure){
      dispatch(const SpotDetailsAction.spotRatingSnackBar(message: 'Unable to rate spot. Something went wrong'));
    }, (success){
      dispatch(const SpotDetailsAction.spotRatingSnackBar(message: 'Thank You. Spot rated successfully'));
    });
  }

  Future<void> getListOfComments({required SkateSpot spot}) async{
    final List<UserComment> listOfComments = [];
    for(var commentID in spot.spotComments){
      final result = await getCommentByIdUseCase(GetCommentByIdParams(commentID: commentID));
      result.fold((failure){
        null;
      }, (comment){
        listOfComments.add(comment);
      });
    }
    dispatch(SpotDetailsAction.listOfCommentDialogBox(listOfComments: listOfComments));
  }

  @override
  Future<void> close() async{
    _streamSubscription?.cancel();
    super.close();
  }

}
