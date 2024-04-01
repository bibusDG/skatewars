import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginWithGoogleUseCase implements UseCaseWithoutParams<void>{
  final UserRelationsRepo repo;
  const LoginWithGoogleUseCase({required this.repo});
  @override
  Future<Either<Failure, String>> call() async{
    return await repo.loginWithGoogle();
    // TODO: implement call
    throw UnimplementedError();
  }

}