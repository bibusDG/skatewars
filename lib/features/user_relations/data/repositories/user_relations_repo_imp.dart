import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import '../../domain/repositories/user_relations_repo.dart';
import '../../user_failures.dart';
import '../datasources/user_relations_data_source.dart';

@Singleton(as: UserRelationsRepo)
class UserRelationsRepoImp implements UserRelationsRepo{
  final UserRelationsDataSource dataSource;
  const UserRelationsRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, Position>> getUserCurrentPosition() async{
    try{
      final result = await dataSource.getUserCurrentPosition();
      return Right(result);
    }catch(error){
      print('Unable to get user posotion');
      return (const Left(GetUserCurrentPositionFailure(failureMessage: 'Unable to get user position')));
    }
    // TODO: implement getUserCurrentPosition
    throw UnimplementedError();
  }
}