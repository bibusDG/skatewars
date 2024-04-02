import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';
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
  Future<Either<Failure, void>> deleteUserFromDataBase({required String userID}) async{
    try{
      final result = await dataSource.deleteUserFromDataBase(userID: userID);
      return Right(result);
    }catch(error){
      print('Unable to delete user from database');
      return (const Left(DeleteUserFromDataBaseFailure(failureMessage: 'Unable to delete user from database')));
    }
    // TODO: implement deleteUserFromDataBase
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logOutUser() async{
    try{
      final result = await dataSource.logOutUser();
      return Right(result);
    }catch(error){
      print('Unabel to logout user');
      return (const Left(LogoutUseFailure(failureMessage: 'Unable to logout user')));
    }

    
    // TODO: implement logOutUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUserWithEmail({required String userLoginEmail, required String userPassword}) async{
    try{
      final result = await dataSource.loginUserWithEmail(userLoginEmail: userLoginEmail, userPassword: userPassword);
      return Right(result);
    }catch(error){
      print('Unable to login user with e-mail and password');
      return (const Left(LoginWithEmailFailure(failureMessage: 'Unable to login with e-mail and password')));
    }

    // TODO: implement loginUserWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithGoogle() async{
    try{
      final result = await dataSource.loginWithGoogle();
      return Right(result);
    }catch(error){
      print('unable to sign in with google');
      return (const Left(LoginWithGoogleFailure(failureMessage: 'Unable to login with google account')));
    }
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> registerNewUser({
    required String userEmail,
    required String userPassword,
    required String userName,
    required String userSureName,
    required String userAvatar,
    required String userMobileToken,
    required String userID,
    required List<String> favouriteSpots,
    required int skatePoints,
    required int skateWarsWon,
    required int skateWarsLost,}) async{
    try{
      final result = await dataSource.registerNewUser(
          userEmail: userEmail,
          userPassword: userPassword,
          userName: userName,
          userSureName: userSureName,
          userAvatar: userAvatar,
          userMobileToken: userMobileToken,
          userID: userID,
          favouriteSpots: favouriteSpots,
          skatePoints: skatePoints,
          skateWarsWon: skateWarsWon,
          skateWarsLost: skateWarsLost);
      return Right(result);
    }catch(error){
      print('Unable to register new user');
      return (const Left(RegisterUserFailure(failureMessage: 'Unable to register new user')));
    }
    // TODO: implement registerNewUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> getUserID({required String userEmail}) async{
    try{
      final result = await dataSource.getUserID(userEmail: userEmail);
      return Right(result);
    }catch(error){
      print('Unable to get user data');
      return (const Left(GetUserIDFailure(failureMessage: 'Unable to set user data')));
    }
    // TODO: implement setUserAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MyUser>> getUserByUserID({required String uid}) async{
    try{
      final result = await dataSource.getUserByUserID(userID: uid);
      return Right(result);
    }catch(error){
      print('Unable to get user by ID');
      return (const Left(GetUserByIDFailure(failureMessage: 'Unable to get user by ID')));
    }
    // TODO: implement getUserByUserID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> createNewEmailPasswordUser({required String userEmail, required String userPassword}) async{
    try{
      final result = await dataSource.createNewEmailPasswordUser(userEmail: userEmail, userPassword: userPassword);
      return Right(result);
    }catch(error){
      print('Unable to create email, password user account');
      return (const Left(CreateEmailPasswordUserFailure(failureMessage: 'Unable to create email, password user account')));
    }
    // TODO: implement createNewEmailPasswordUser
    throw UnimplementedError();
  }
}