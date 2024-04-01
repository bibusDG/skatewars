import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart';

@injectable
class GetUserByIDUseCase implements UseCaseWithParams<MyUser, GetUserByIdParams>{
  final UserRelationsRepo repo;
  const GetUserByIDUseCase({required this.repo});

  @override
  Future<Either<Failure, MyUser>> call(GetUserByIdParams params) async{
    return await repo.getUserByUserID(uid: params.userID);
    // TODO: implement call
    throw UnimplementedError();
  }

}

class GetUserByIdParams extends Equatable{
  final String userID;
  const GetUserByIdParams({required this.userID});

  @override
  List<Object> get props => [userID];

}