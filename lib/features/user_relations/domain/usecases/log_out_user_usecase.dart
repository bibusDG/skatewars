import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class LogOutUserUseCase implements UseCaseWithoutParams<void>{
  final UserRelationsRepo repo;
  const LogOutUserUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call() async{
    return await repo.logOutUser();
    // TODO: implement call
    throw UnimplementedError();
  }
}