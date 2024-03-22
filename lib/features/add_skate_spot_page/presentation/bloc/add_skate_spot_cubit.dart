import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import '../../../login_user_page/domain/usecases/get_user_curret_position_usecase.dart';
import '/../core/classes/choose_image_to_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/add_skate_spot_usecase.dart';

part 'add_skate_spot_state.dart';
part 'add_skate_spot_action.dart';
part 'add_skate_spot_cubit.freezed.dart';

@injectable
class AddSkateSpotCubit extends ActionCubit<AddSkateSpotState, AddSkateSpotAction> {
  final AddSkateSpotUseCase addSkateSpotUseCase;
  final GetUserCurrentPositionUseCase getUserCurrentPositionUseCase;
  AddSkateSpotCubit({required this.addSkateSpotUseCase, required this.getUserCurrentPositionUseCase}) : super(const AddSkateSpotState.initial());

  Future<void> initAddSkateSpotPage({required bool userLoggedIn}) async{
    emit(const AddSkateSpotState.addSkateSpotPageLoading());
    if(userLoggedIn){
      emit(AddSkateSpotState.addSkateSpotPageLoaded(userLoggedIn: userLoggedIn));
    }else{
      emit(const AddSkateSpotState.addSkateSpotPageError(message: 'User not logged in'));
    }

  }

  Future<void> getSkateSpotImages() async{
    final myGallery = await ChooseImageToDatabase().chooseManyImageFromGallery();
    if(myGallery.isEmpty){
      emit(const AddSkateSpotState.addSkateSpotPageLoaded(userLoggedIn: true));
    }else{
      emit(AddSkateSpotState.gallery(gallery: myGallery));
    }
  }

  Future<void> addSkateSpot({
    required String spotDescription,
    required String spotLang,
    required String spotLat,
    required String spotName,
    required List<String> spotPhotos,
    required List<String> spotProperties
  }) async{
    final result = await addSkateSpotUseCase(AddSkateSpotParams(
        spotID: '',
        spotComments: const [],
        spotDescription: spotDescription,
        spotLang: spotLang,
        spotLat: spotLat,
        spotName: spotName,
        spotPhotos: spotPhotos,
        spotProperties: spotProperties,
        spotRanks: const [5.0],
        spotRiders: const []));
    result.fold((failure){
      emit(const AddSkateSpotState.addSkateSpotPageError(message: 'Ups..something went wrong'));
    }, (success){

    });
  }

  Future<Position> getSpotPosition() async{
    final result = await getUserCurrentPositionUseCase.call();
    return result.fold((failure){
      return Position.fromMap('oo');
    }, (success){
      return success;
    });
  }

}
