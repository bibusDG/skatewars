import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/features/login_user_page/data/datasources/login_user_data_source.dart';
import 'package:skatewars/features/login_user_page/domain/repositories/login_user_repo.dart';
import 'package:skatewars/features/login_user_page/login_user_failures.dart';

@Singleton(as: LoginUserRepo)
class LoginUserRepoImp implements LoginUserRepo{
  final LoginUserDataSource dataSource;
  const LoginUserRepoImp({required this.dataSource});

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