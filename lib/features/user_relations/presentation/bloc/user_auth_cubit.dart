import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/classes/choose_image_to_database.dart';
import 'package:skatewars/core/constants/constants.dart';

import '../../domain/entities/my_user.dart';
import '../../domain/usecases/log_out_user_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/logint_with_email_usecase.dart';
import '../../domain/usecases/register_new_user_usecase.dart';
import '../../domain/usecases/get_user_id_usecase.dart';

part 'user_auth_state.dart';
part 'user_auth_action.dart';
part 'user_auth_cubit.freezed.dart';

@injectable
class UserAuthCubit extends ActionCubit<UserAuthState, UserAuthAction> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogOutUserUseCase logOutUserUseCase;
  final RegisterNewUserUseCase registerNewUseUseCase;
  final GetUserIDUseCase getUserIDUseCase;
  final LoginWithEmailUseCase loginWithEmailUseCase;
  UserAuthCubit({
    required this.loginWithEmailUseCase,
    required this.getUserIDUseCase,
    required this.registerNewUseUseCase,
    required this.loginWithGoogleUseCase,
    required this.logOutUserUseCase}) : super(const UserAuthState.initial());

  Future<void> loginInitialPage({required String userLoggedIn}) async{
    if(userLoggedIn == 'false'){
      emit(const UserAuthState.userLoggedOutInitialPage());
    }else{
      emit(const UserAuthState.userLoggedInInitialPage());
    }
  }

  Future<void> registerInitialPage() async{
    emit(const UserAuthState.userRegisterInitialPage());
  }

  Future<void> logOutUser() async{
    final result = await logOutUserUseCase();
    result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Unable to log-out'));
    }, (success){
      USER_LOGGED_IN = false;
      LOGGED_USER = MyUser.empty();
      emit(const UserAuthState.loggedOutSuccess(message: 'LogOut successful'));
    });
  }

  Future<void> loginWithGoogle() async{
    emit(const UserAuthState.loginInProgress());
    ///login with google account
    final result = await loginWithGoogleUseCase();
    result.fold((failure){
    emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
    }, (credential) async{
      final result = await getUserIDUseCase(GetUserIDParams(userEmail: credential.user!.email!));
      result.fold((failure){
        emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
      }, (success){
        USER_LOGGED_IN = true;
        emit(UserAuthState.loginSuccess(message: 'Success', uid: success));
      });
    });
  }

  Future<void> loginWithEmail({required String userEmail, required String  userPassword}) async{
    emit(const UserAuthState.loginInProgress());
    final result = await loginWithEmailUseCase(LoginWithEmailParams(userEmail: userEmail, userPassword: userPassword));
    result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
    }, (success) async{
      switch (success){
        case 'wrong-password' :
          print('dd');
        case 'invalid-email' :
          print('dd');
        case 'INVALID_LOGIN_CREDENTIALS' :
          print('dd');
        case 'invalid-credential' :
          print('dd');
        case 'too-many-requests' :
          print('dd');
        default: final result = await getUserIDUseCase(GetUserIDParams(userEmail: userEmail));
        result.fold((l){
          emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
        }, (userID){
          USER_LOGGED_IN = true;
          emit(UserAuthState.loginSuccess(message: 'Success', uid: success));
        });

      }
    });
  }

  Future<void> registerWithGoogle() async{
    emit(const UserAuthState.registeringInProgress());
    ///login with google account
    final result = await loginWithGoogleUseCase();
    result.fold((failure){
      emit(const UserAuthState.registerFailure(message: 'Registration failure'));
    }, (credential) async{
      if(credential.additionalUserInfo!.isNewUser){
        final _image = await ImageOperations().changeHttpImageToBase64(imageUrl: credential.user!.photoURL!);
        final result = await registerNewUseUseCase(RegisterNewUserParams(
            userEmail: credential.user!.email!,
            userPassword: '',
            userName: credential.user!.displayName!,
            userSureName: '',
            userAvatar: _image,
            userMobileToken: '',
            userID: '',
            favouriteSpots: const [],
            skatePoints: 0,
            skateWarsWon: 0,
            skateWarsLost: 0));
        result.fold((failure){
          emit(const UserAuthState.registerFailure(message: 'Register failure'));
        }, (success) async{
          emit(const UserAuthState.loginInProgress());
          final result = await getUserIDUseCase(GetUserIDParams(userEmail: credential.user!.email!));
          result.fold((failure){
            emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
          }, (success){
            USER_LOGGED_IN = true;
            emit(UserAuthState.loginSuccess(message: 'Login Success', uid: success));
          });
        });
      }else{
        emit(const UserAuthState.userLoggedOutInitialPage());
      }
    });
  }

}
