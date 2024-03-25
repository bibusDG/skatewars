import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/show_skate_spots_page/data/datasources/show_skate_spots_data_source.dart';
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart';
import 'package:skatewars/features/show_skate_spots_page/show_skate_spots_failures.dart';

@Singleton(as: ShowSkateSpotsRepo)
class ShowSkateSpotRepoImp implements ShowSkateSpotsRepo{
  final ShowSkateSpotsDataSource showSkateSpotsDataSource;
  const ShowSkateSpotRepoImp({required this.showSkateSpotsDataSource});

  @override
  Future<Either<Failure, Stream<List<SkateSpot>>>> streamSkateSpots({required String distance}) async{
    try{
      final result = showSkateSpotsDataSource.streamSkateSpots(distance: distance);
      return Right(result);
    }catch(error){
      print('Unable to get skate spots');
      return (const Left(ShowSkateSpotsFailures(failureMessage: 'Unable to get skate spots')));
    }
    // TODO: implement streamSkateSpots
    throw UnimplementedError();
  }
}