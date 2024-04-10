import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class DeleteUserUseCase implements UseCaseWithParams<void, DeleteUserParams>{
  final UserRelationsRepo repo;
  const DeleteUserUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(DeleteUserParams params) async{
    return await repo.deleteUserFromDataBase(userID: params.userID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class DeleteUserParams extends Equatable{
  final String userID;
  const DeleteUserParams({required this.userID});

  @override
  List<Object> get props => [userID];

}