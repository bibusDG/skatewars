import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class ChangeUserCredentialsUseCase implements UseCaseWithParams<void, ChangeUserCredentialsParams>{
  final UserRelationsRepo repo;
  const ChangeUserCredentialsUseCase({required this.repo});


  @override
  Future<Either<Failure, void>> call(ChangeUserCredentialsParams params) async{
    return await repo.changeUserCredentials(
        userID: params.userID,
        credential: params.credential,
        newCredentialValue: params.newCredentialValue);
    // TODO: implement call
    throw UnimplementedError();
  }}

class ChangeUserCredentialsParams extends Equatable{
  final String userID;
  final String credential;
  final String newCredentialValue;

  const ChangeUserCredentialsParams({required this.newCredentialValue, required this.credential, required this.userID});

  @override
  List<Object> get props => [userID, credential, newCredentialValue];

}