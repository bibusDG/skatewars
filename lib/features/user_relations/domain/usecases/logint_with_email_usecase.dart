import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class LoginWithEmailUseCase implements UseCaseWithParams<String, LoginWithEmailParams>{
  final UserRelationsRepo repo;
  const LoginWithEmailUseCase({required this.repo});

  @override
  Future<Either<Failure, String>> call(LoginWithEmailParams params) async{
    return await repo.loginUserWithEmail(userLoginEmail: params.userEmail, userPassword: params.userPassword);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class LoginWithEmailParams extends Equatable{
  final String userEmail;
  final String userPassword;
  const LoginWithEmailParams({required this.userEmail, required this.userPassword});

  @override
  List<Object> get props => [userPassword, userEmail];

}