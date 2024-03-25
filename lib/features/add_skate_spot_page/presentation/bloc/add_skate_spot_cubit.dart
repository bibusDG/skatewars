import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_spot_map_bloc/add_spot_map_cubit.dart';

import '../../../user_relations/domain/usecases/get_user_curret_position_usecase.dart';
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
    if(spotName.isEmpty){
      dispatch(const AddSkateSpotAction.inputFieldError(message: 'Please provide name for Your spot'));
    }else if(spotProperties.isEmpty){
      dispatch(const AddSkateSpotAction.inputFieldError(message: 'Please give at least one property'));
    }else if(spotPhotos.isEmpty){
      dispatch(const AddSkateSpotAction.inputFieldError(message: 'Please provide at least one photo'));
    }else if(spotLang.isEmpty || spotLat.isEmpty){
      dispatch(const AddSkateSpotAction.inputFieldError(message: 'Something is wrong with spot localization.'));
    }else{
      emit(const AddSkateSpotState.creatingNewSkateSpot());
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
        emit(const AddSkateSpotState.creatingSpotError(message: 'Ups..something went wrong. Try again'));
      }, (success){
        emit(const AddSkateSpotState.creatingSpotSuccess(message: 'Your spot has been successfully created'));
      });
    }
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
