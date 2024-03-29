import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class UserLoggedInUseCase implements UseCaseWithoutParams<Stream<User?>>{
  final UserRelationsRepo repo;
  const UserLoggedInUseCase({required this.repo});

  @override
  Future<Either<Failure, Stream<User?>>> call() async{
    return await repo.userIsLoggedIn();
    // TODO: implement call
    throw UnimplementedError();
  }
}