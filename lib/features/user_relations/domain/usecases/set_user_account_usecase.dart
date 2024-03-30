import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class SetUserAccountUseCase implements UseCaseWithParams<void, SetUserAccountParams>{
  final UserRelationsRepo repo;
  const SetUserAccountUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(SetUserAccountParams params) async{
    return await repo.setUserAccount(userEmail: params.userEmail);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class SetUserAccountParams extends Equatable{
  final String userEmail;
  const SetUserAccountParams({required this.userEmail});

  @override
  List<Object> get props => [userEmail];
}