import 'package:dartz/dartz.dart';
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

  @override
  Future<Either<Failure, void>> addSpotToUserFavorites({required String spotID, required String userID}) async{
    try{
      final result = await showSkateSpotsDataSource.addSpotToUserFavorites(spotID: spotID, userID: userID);
      return Right(result);
    }catch(error){
      print('Unable to add spot to favorites');
      return (const Left(AddSpotToUserFavorites(failureMessage: 'Unable to add spot to user favorites')));
    }
    // TODO: implement addSpotToUserFavorites
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SkateSpot>> getSpotByID({required String spotID}) async{
    try{
      final result = await showSkateSpotsDataSource.getSpotByID(spotID: spotID);
      return Right(result);
    }catch(error){
      print('Unable to get spot by spotID');
      return (const Left(GetSpotByIdFailure(failureMessage: 'Unable to get spot by spotID')));
    }
    // TODO: implement getSpotByID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeSpotFromUserFavorites({required String spotID, required String userID}) async{
    try{
      final result = await showSkateSpotsDataSource.removeSpotFromUserFavorites(spotID: spotID, userID: userID);
      return Right(result);
    }catch(error){
      print('Unable to remove spot from user favorites');
      return (const Left(RemoveSpotFromUserFavorites(failureMessage: 'Unable to remove spot from user favorites')));
    }
    // TODO: implement removeSpotFromUserFavorites
    throw UnimplementedError();
  }
}