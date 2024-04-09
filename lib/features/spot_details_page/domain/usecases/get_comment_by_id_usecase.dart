import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/spot_details_page/domain/entities/user_comment.dart';
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart';

@injectable
class GetCommentByIdUseCase implements UseCaseWithParams<UserComment, GetCommentByIdParams>{
  final SpotDetailsRepo repo;
  const GetCommentByIdUseCase({required this.repo});

  @override
  Future<Either<Failure, UserComment>> call(GetCommentByIdParams params) async{
    return await repo.getCommentByID(commentID: params.commentID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetCommentByIdParams extends Equatable{
  final String commentID;
  const GetCommentByIdParams({required this.commentID});

  @override
  List<Object> get props => [commentID];

}