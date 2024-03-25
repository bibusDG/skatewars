import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart';

class ShowSkateSpotsUseCase implements UseCaseWithParams<Stream<List<SkateSpot>>, ShowSkateSpotsParams>{
  final ShowSkateSpotsRepo showSkateSpotsRepo;
  const ShowSkateSpotsUseCase({required this.showSkateSpotsRepo});

  @override
  Future<Either<Failure, Stream<List<SkateSpot>>>> call(ShowSkateSpotsParams params) async{
    return await showSkateSpotsRepo.streamSkateSpots(distance: params.distance, userPosition: params.userPosition);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class ShowSkateSpotsParams extends Equatable{
  final Position userPosition;
  final String distance;
  const ShowSkateSpotsParams({
    required this.userPosition,
    required this.distance,
});
  @override
  List<Object?> get props => [distance, userPosition];
}