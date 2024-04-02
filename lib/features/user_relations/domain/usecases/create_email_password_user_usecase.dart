import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class CreateEmailPasswordUserUseCase implements UseCaseWithParams<String, CreateEmailPasswordUserParams>{
  final UserRelationsRepo repo;
  const CreateEmailPasswordUserUseCase({required this.repo});

  @override
  Future<Either<Failure, String>> call(CreateEmailPasswordUserParams params) async{
    return await repo.createNewEmailPasswordUser(userEmail: params.userEmail, userPassword: params.userPassword);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class CreateEmailPasswordUserParams extends Equatable{
  final String userEmail;
  final String userPassword;
  const CreateEmailPasswordUserParams({required this.userEmail, required this.userPassword});

  @override
  List<Object> get props => [userEmail, userPassword];

}