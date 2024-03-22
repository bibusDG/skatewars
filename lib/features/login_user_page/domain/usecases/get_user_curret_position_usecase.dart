import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/login_user_page/domain/repositories/login_user_repo.dart';

@injectable
class GetUserCurrentPositionUseCase implements UseCaseWithoutParams{
  final LoginUserRepo repo;
  const GetUserCurrentPositionUseCase({required this.repo});

  @override
  Future<Either<Failure, dynamic>> call() async{
    return await repo.getUserCurrentPosition();
    // TODO: implement call
    throw UnimplementedError();
  }
}