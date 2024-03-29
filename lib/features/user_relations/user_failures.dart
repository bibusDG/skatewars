import 'package:skatewars/core/failure/failure.dart';

class GetUserCurrentPositionFailure extends Failure{
  const GetUserCurrentPositionFailure({required super.failureMessage});
}
class DeleteUserFromDataBaseFailure extends Failure{
  const DeleteUserFromDataBaseFailure({required super.failureMessage});
}
class LogoutUseFailure extends Failure{
  const LogoutUseFailure({required super.failureMessage});
}

class LoginWithEmailFailure extends Failure{
  const LoginWithEmailFailure({required super.failureMessage});
}

class RegisterUserFailure extends Failure{
  const RegisterUserFailure({required super.failureMessage});
}

class LoginWithGoogleFailure extends Failure{
  const LoginWithGoogleFailure({required super.failureMessage});
}