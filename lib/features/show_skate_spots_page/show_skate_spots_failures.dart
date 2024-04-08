import 'package:skatewars/core/failure/failure.dart';

class ShowSkateSpotsFailures extends Failure{
  const ShowSkateSpotsFailures({required super.failureMessage});
}

class AddSpotToUserFavorites extends Failure{
  const AddSpotToUserFavorites({required super.failureMessage});
}

class RemoveSpotFromUserFavorites extends Failure{
  const RemoveSpotFromUserFavorites({required super.failureMessage});
}

class GetSpotByIdFailure extends Failure{
  const GetSpotByIdFailure({required super.failureMessage});
}