import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';

import '../repositories/user_relations_repo.dart';

@injectable
class GetUserCurrentPositionUseCase implements UseCaseWithoutParams{
  final UserRelationsRepo repo;
  const GetUserCurrentPositionUseCase({required this.repo});

  @override
  Future<Either<Failure, Position>> call() async{
    return await repo.getUserCurrentPosition();
    // TODO: implement call
    throw UnimplementedError();
  }
}