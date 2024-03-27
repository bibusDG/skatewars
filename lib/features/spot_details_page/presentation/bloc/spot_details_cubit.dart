import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

import '../../domain/usecases/get_spot_details_usecase.dart';

part 'spot_details_state.dart';
part 'spot_details_cubit.freezed.dart';
@injectable
class SpotDetailsCubit extends Cubit<SpotDetailsState> {
  final GetSpotDetailsUseCase getSpotDetailsUseCase;
  SpotDetailsCubit({required this.getSpotDetailsUseCase}) : super(const SpotDetailsState.initial());

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
  @override
  Future<void> close() async{
    _streamSubscription?.cancel();
    super.close();
  }
}
