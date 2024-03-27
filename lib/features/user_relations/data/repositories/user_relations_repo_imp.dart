import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import '../../domain/repositories/user_relations_repo.dart';
import '../../user_failures.dart';
import '../datasources/user_relations_data_source.dart';

@Singleton(as: UserRelationsRepo)
class UserRelationsRepoImp implements UserRelationsRepo{
  final UserRelationsDataSource dataSource;
  const UserRelationsRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, Position>> getUserCurrentPosition() async{
    try{
      final result = await dataSource.getUserCurrentPosition();
      return Right(result);
    }catch(error){
      print('Unable to get user posotion');
      return (const Left(GetUserCurrentPositionFailure(failureMessage: 'Unable to get user position')));
    }
    // TODO: implement getUserCurrentPosition
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteUserFromDataBase({required String userID}) {
    // TODO: implement deleteUserFromDataBase
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logOutUser() {
    // TODO: implement logOutUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUserWithEmail({required String userLoginEmail, required String userPassword}) {
    // TODO: implement loginUserWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> registerNewUser({required String userEmail, required String userPassword}) {
    // TODO: implement registerNewUser
    throw UnimplementedError();
  }
}