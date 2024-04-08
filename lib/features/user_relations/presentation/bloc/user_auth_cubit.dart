import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/classes/choose_image_to_database.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/user_relations/domain/usecases/get_user_by_id_usecase.dart';

import '../../../add_skate_spot_page/domain/entities/skateSpot.dart';
import '../../../show_skate_spots_page/domain/usecases/get_spot_by_id_usecase.dart';
import '../../../show_skate_spots_page/domain/usecases/remove_spot_from_favorites_usecase.dart';
import '../../domain/entities/my_user.dart';
import '../../domain/usecases/create_email_password_user_usecase.dart';
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
  final CreateEmailPasswordUserUseCase createEmailPasswordUserUseCase;
  final GetUserByIDUseCase getUserByIDUseCase;
  final RemoveSpotFromFavoritesUseCase removeSpotFromFavoritesUseCase;
  final GetSpotByIdUseCase getSpotByIdUseCase;
  UserAuthCubit({
    required this.getSpotByIdUseCase,
    required this.removeSpotFromFavoritesUseCase,
    required this.createEmailPasswordUserUseCase,
    required this.loginWithEmailUseCase,
    required this.getUserIDUseCase,
    required this.registerNewUseUseCase,
    required this.loginWithGoogleUseCase,
    required this.getUserByIDUseCase,
    required this.logOutUserUseCase}) : super(const UserAuthState.initial());

  Future<void> loginInitialPage({required String userLoggedIn, required String uid}) async{
    if(userLoggedIn == 'false'){
      emit(const UserAuthState.userLoggedOutInitialPage());
    }else{
      final result = await getUserByIDUseCase(GetUserByIdParams(userID: uid));
      result.fold((failure){
        emit(const UserAuthState.loginPageError(message: 'Upps...'));
      }, (user) async{
        final List<SkateSpot> userFavSpots = [];
        for(var spotID in user.favouriteSpots){
          final spot = await getSpotByIdUseCase(GetSpotByIdParams(spotID: spotID));
          spot.fold((failure){
            null;
          }, (spot){
            userFavSpots.add(spot);
          });
        }
        emit(UserAuthState.userLoggedInInitialPage(user: user, favSpots: userFavSpots));
      });
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
      if(credential.additionalUserInfo!.isNewUser){
        emit(const UserAuthState.loginPageError(message: 'It looks You do not have account. Please register first.'));
      }else{
        final result = await getUserIDUseCase(GetUserIDParams(userEmail: credential.user!.email!));
        result.fold((failure){
          emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
        }, (success){
          USER_LOGGED_IN = true;
          emit(UserAuthState.loginSuccess(message: 'Success', uid: success));
        });
      }
    });
  }

  Future<void> loginWithEmail({required String userEmail, required String  userPassword}) async{
    final result = await loginWithEmailUseCase(LoginWithEmailParams(userEmail: userEmail, userPassword: userPassword));
    result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
    }, (success) async{
      switch (success){
        case 'wrong-password' :
          dispatch(const UserAuthAction.loginActionMessage(message: 'Invalid password. Try again'));
        case 'invalid-email' :
          dispatch(const UserAuthAction.loginActionMessage(message: 'Invalid e-mail. Try again'));
        case 'INVALID_LOGIN_CREDENTIALS' :
          print('dd');
        case 'invalid-credential' :
          dispatch(const UserAuthAction.loginActionMessage(message: 'Invalid login credentials. Try again.'));
        case 'too-many-requests' :
          dispatch(const UserAuthAction.loginActionMessage(message: 'To many requests. Try again later'));
        default:
          emit(const UserAuthState.loginInProgress());
          final result = await getUserIDUseCase(GetUserIDParams(userEmail: userEmail));
        result.fold((l){
          emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
        }, (userID){
          USER_LOGGED_IN = true;
          emit(UserAuthState.loginSuccess(message: 'Success', uid: userID));
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
        emit(const UserAuthState.registerFailure(message: 'User with this e-mail already exists. Please login via Google.'));
      }
    });
  }

  Future<void> registerWithEmailAndPassword({required String userEmail, required String userPassword}) async{
    final result = await createEmailPasswordUserUseCase(CreateEmailPasswordUserParams(userEmail: userEmail, userPassword: userPassword));
    result.fold((failure){
      emit(const UserAuthState.registerFailure(message: 'Unable to register new user'));
    }, (success) async{
       switch (success){
         case 'email-already-in-use' :
            dispatch(const UserAuthAction.signInActionMessage(message: 'User with this e-mail is already signed-in. Try another credentials.'));
         case 'invalid-email':
           dispatch(const UserAuthAction.signInActionMessage(message: 'Invalid e-mail. Check if e-mial is correct.'));
         case 'weak-password':
           dispatch(const UserAuthAction.signInActionMessage(message: 'Your password is to weak. Try longer password.'));
         default : final result = await registerNewUseUseCase(RegisterNewUserParams(
             userEmail: userEmail,
             userPassword: userPassword,
             userName: '',
             userSureName: '',
             userAvatar: '',
             userMobileToken: '',
             userID: success,
             favouriteSpots: const [],
             skatePoints: 0,
             skateWarsWon: 0,
             skateWarsLost: 0));
         result.fold((failure){
           emit(const UserAuthState.registerFailure(message: 'Unable to register new user'));
         }, (success){
           emit(const UserAuthState.registerSuccess(message: 'Registration successful'));
         });

       }
    });
  }

  Future<void> getSpotByID({required String spotID}) async{
    final result = await getSpotByIdUseCase(GetSpotByIdParams(spotID: spotID));
    result.fold((failure){
      null;
    }, (success){
      return success;
    });
  }

  Future<void> removeSpotFromFav({required MyUser user, required String spotID, required List<SkateSpot> spots}) async{
    final result = await removeSpotFromFavoritesUseCase(RemoveSpotFromFavoritesParams(userID: user.userID, spotID: spotID));
    result.fold((failure){

    }, (success){
      print('spot deleted');
    });
  }

}
