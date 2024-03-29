import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/log_out_user_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/register_new_user_usecase.dart';

part 'user_auth_state.dart';
part 'user_auth_cubit.freezed.dart';

@injectable
class UserAuthCubit extends Cubit<UserAuthState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogOutUserUseCase logOutUserUseCase;
  final RegisterNewUserUseCase registerNewUseUseCase;
  UserAuthCubit({required this.registerNewUseUseCase, required this.loginWithGoogleUseCase, required this.logOutUserUseCase}) : super(const UserAuthState.initial());

  Future<void> loginInitialPage() async{
    emit(const UserAuthState.loginInitialPage());
  }

  Future<void> logOutUser() async{
    final result = await logOutUserUseCase();
    result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Unable to log-out'));
    }, (success){
      emit(const UserAuthState.loginInitialPage());
    });
  }

  Future<void> loginWithGoogle() async{
    emit(const UserAuthState.loginInProgress());
    final result = await loginWithGoogleUseCase();
    result.fold((failure){
    emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
    }, (success) async{
      emit(const UserAuthState.loginInProgress());
      final result = await registerNewUseUseCase(RegisterNewUserParams(
          userEmail: success.user!.email!,
          userPassword: '',
          userName: success.user!.displayName!,
          userSureName: '',
          userAvatar: success.user!.photoURL!,
          userMobileToken: '',
          userID: '',
          favouriteSpots: const [],
          skatePoints: 0,
          skateWarsWon: 0,
          skateWarsLost: 0));
      result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
      }, (success){
      emit(const UserAuthState.loginSuccess(message: 'Success'));
      });

    });
  }

}
