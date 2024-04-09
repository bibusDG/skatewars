import 'package:skatewars/core/failure/failure.dart';

class GetsPotDetailsFailure extends Failure{
  const GetsPotDetailsFailure({required super.failureMessage});
}

class AddUserToSpotFailure extends Failure{
  const AddUserToSpotFailure({required super.failureMessage});
}

class RemoveUserFromSpotFailure extends Failure{
  const RemoveUserFromSpotFailure({required super.failureMessage});
}

class RateSpotFailure extends Failure{
  const RateSpotFailure({required super.failureMessage});
}

class GetCommentFailure extends Failure{
  const GetCommentFailure({required super.failureMessage});
}