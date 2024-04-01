import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class GetUserIDUseCase implements UseCaseWithParams<void, GetUserIDParams>{
  final UserRelationsRepo repo;
  const GetUserIDUseCase({required this.repo});

  @override
  Future<Either<Failure, String>> call(GetUserIDParams params) async{
    return await repo.getUserID(userEmail: params.userEmail);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetUserIDParams extends Equatable{
  final String userEmail;
  const GetUserIDParams({required this.userEmail});

  @override
  List<Object> get props => [userEmail];
}