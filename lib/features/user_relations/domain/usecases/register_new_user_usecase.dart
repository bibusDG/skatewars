import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterNewUserUseCase implements UseCaseWithParams<void, RegisterNewUserParams>{
  final UserRelationsRepo repo;
  const RegisterNewUserUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(RegisterNewUserParams params) async{
    return await repo.registerNewUser(
        userEmail: params.userEmail,
        userPassword: params.userPassword,
        userName: params.userName,
        userSureName: params.userSureName,
        userAvatar: params.userAvatar,
        userMobileToken: params.userMobileToken,
        userID: params.userID,
        favouriteSpots: params.favouriteSpots,
        skatePoints: params.skatePoints,
        skateWarsWon: params.skateWarsWon,
        skateWarsLost: params.skateWarsLost);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class RegisterNewUserParams extends Equatable{
  final String userEmail;
  final String userPassword;
  final String userName;
  final String userSureName;
  final String userAvatar;
  final String userMobileToken;
  final String userID;
  final List<String> favouriteSpots;
  final int skatePoints;
  final int skateWarsWon;
  final int skateWarsLost;
  const RegisterNewUserParams({
    required this.userEmail,
    required this.userPassword,
    required this.userName,
    required this.userSureName,
    required this.userAvatar,
    required this.userMobileToken,
    required this.userID,
    required this.favouriteSpots,
    required this.skatePoints,
    required this.skateWarsWon,
    required this.skateWarsLost,
});

  @override
  List<Object> get props => [
    userID, userPassword, userEmail
  ];

}