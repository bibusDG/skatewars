import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/spot_details_page/data/datasources/spot_details_data_source.dart';
import 'package:skatewars/features/spot_details_page/domain/entities/user_comment.dart';
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart';
import 'package:skatewars/features/spot_details_page/spot_details_failures.dart';

@Singleton(as:SpotDetailsRepo)
class SpotDetailsRepoImp implements SpotDetailsRepo{
  final SpotDetailsDatasource spotDetailsDatasource;
  const SpotDetailsRepoImp({required this.spotDetailsDatasource});

  @override
  Future<Either<Failure, Stream<SkateSpot>>> getSpotDetails({required String spotID}) async{
    try{
      final result = spotDetailsDatasource.getSpotDetails(spotID: spotID);
      return Right(result);
    }catch(error){
      print('Unable to get spot details');
      return (const Left(GetsPotDetailsFailure(failureMessage: 'Unable to get spot details')));
    }
    // TODO: implement getSpotDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> addUserToSpot({required String userID, required String spotID}) async{
    try{
      final result = await spotDetailsDatasource.addUserToSpot(userID: userID, spotID: spotID);
      return Right(result);
    }catch(error){
      print('Unable to add rider to spot');
      return (const Left(AddUserToSpotFailure(failureMessage: 'Unable to add user to spot')));
    }
    // TODO: implement addUserToSpot
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeUserFromSpot({required String userID, required String spotID}) async{
    try{
      final result = await spotDetailsDatasource.removeUserFromSpot(userID: userID, spotID: spotID);
      return Right(result);
    }catch(error){
      print('Unable to remove user from spot');
      return (const Left(RemoveUserFromSpotFailure(failureMessage: 'Unable to remove user from spot')));
    }
    // TODO: implement removeUserFromSpot
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> rateSpot({
    required String userName,
    required String comment,
    required String creationDate,
    required String spotID,
    required double userRate}) async{
    try{
      final result = await spotDetailsDatasource.rateSpot(
          userName: userName,
          comment: comment,
          creationDate: creationDate,
          spotID: spotID,
          userRate: userRate);
      return Right(result);
    }catch(error){
      print('Unabel to rate spot');
      return (const Left(RateSpotFailure(failureMessage: 'Unable to rate spot')));
    }
    // TODO: implement rateSpot
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserComment>> getCommentByID({required String commentID}) async{
    try{
      final result = await spotDetailsDatasource.getCommentByID(commentID: commentID);
      return Right(result);
    }catch(error){
      print('Unabele to get comment by ID');
      return (const Left(GetCommentFailure(failureMessage: 'Unable to get comment by ID')));
    }
    // TODO: implement getCommentByID
    throw UnimplementedError();
  }
}