import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:skatewars/core/classes/choose_image_to_database.dart';
import 'package:skatewars/core/classes/custom_snackbar.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/core/custom_widgets/custom_bottom_app_bar.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/user_relations/presentation/bloc/user_auth_cubit.dart';

import '../../../../core/custom_widgets/custom_text_form_field.dart';
import '../../domain/entities/my_user.dart';

class UserLoginPage extends HookWidget {
  final String uid;
  final String userLoggedIn;
  const UserLoginPage({super.key, required this.userLoggedIn, required this.uid});

  @override
  Widget build(BuildContext context) {

    final _userEmail = useTextEditingController();
    final _userPassword = useTextEditingController();

    final _userRegisterEmail = useTextEditingController();
    final _userRegisterPassword = useTextEditingController();
    final _userRepeatPassword = useTextEditingController();

    final _authCubit = useBloc<UserAuthCubit>();
    final _authState = useBlocBuilder(_authCubit);

    useEffect((){
      _authCubit.loginInitialPage(userLoggedIn: userLoggedIn, uid: uid);
      return null;
    },
      [_authCubit],
    );

    useBlocListener<UserAuthCubit, UserAuthState>(_authCubit, (bloc, current, context) {
      current.whenOrNull(
        loginSuccess: (message, uid) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page', pathParameters: {'uid' : uid});
          }
        },
        loggedOutSuccess: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page', pathParameters: {'uid' : 'null'});
          }
        },
        loginPageError: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            _authCubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: uid);
          }
        },
        registerFailure: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            _authCubit.registerInitialPage();
          }
        },
        deleteUserSuccess: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page', pathParameters: {'uid' : 'null'});
          }
        },
        deleteUserFailure: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            _authCubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: uid);
          }
        },
        registerSuccess: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page', pathParameters: {'uid' : uid});
          }
        }
      );
    });

    useActionListener(_authCubit, (action){
      action.whenOrNull(
        loginActionMessage: (message) => CustomSnackBar().mySnackBar(context, message),
        signInActionMessage: (message) => CustomSnackBar().mySnackBar(context, message),
        dialogBox: (title, message) async{
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Center(child: Text(title)),
              content: SizedBox(height: 50, width: 350, child: Center(child: Text(message))),);
          });
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.pop();
          }
        },
      );
    });

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: _authState.maybeWhen(
            userRegisterInitialPage: () => CustomBottomAppBar(uid: uid),
            userLoggedOutInitialPage: () => CustomBottomAppBar(uid: uid),
            userLoggedInInitialPage: (user, favSpots) => CustomBottomAppBar(uid: uid),
            orElse: () { return null; }
        ),
        appBar: AppBar(title: _authState.maybeWhen(
            userRegisterInitialPage: () => const Text('REGISTRATION PAGE'),
            userLoggedInInitialPage: (user, favSpots) => const Text('MY ACCOUNT'),
            userLoggedOutInitialPage: () => const Text('LOGIN PAGE'),
            orElse: (){return null;}),
        ),
        body: _authState.whenOrNull(
          registeringInProgress: () => const Center(child: CircularProgressIndicator(),),
          registerSuccess: (message) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 50.0,),
              const SizedBox(height: 20.0,),
              Text(message),
              const SizedBox(height: 20.0,),
              const Text('Please login to your account', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),)
            ],
          ),),
          registerFailure: (message) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50.0,),
              const SizedBox(height: 20.0,),
              Text(message),
            ],
          ),),
          userRegisterInitialPage: () => SignUpUserPage(
              cubit: _authCubit,
              userRepeatPassword: _userRepeatPassword,
              userRegisterEmail: _userRegisterEmail,
              userRegisterPassword: _userRegisterPassword,
              uid: uid,
          ),
          userLoggedInInitialPage: (user, favSpots) => LogInInitialPage(cubit: _authCubit, user: user, favSpots: favSpots,),
          userLoggedOutInitialPage:() => LogOutInitialPage(userEmail: _userEmail, userPassword: _userPassword, authCubit: _authCubit),
          loginSuccess: (message, uid) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 50.0,),
              const SizedBox(height: 20.0,),
              Text(message),
            ],
          ),),
          loginInProgress: () => const Center(child: CircularProgressIndicator(),),
          loginFailed: (message) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50.0,),
              const SizedBox(height: 20.0,),
              Text(message),
            ],
          ),),
          loginPageLoading: () => const Center(child: CircularProgressIndicator(),),
          loggedOutSuccess: (message) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline_outlined, size: 50.0, color: Colors.green,),
              const SizedBox(height: 20.0,),
              Text(message),
            ],
          ),),
          loginPageError: (message) => Center(child: Text(message)),
          deletingUser: () => const Center(child: CircularProgressIndicator(),),
          deleteUserFailure: (message) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50.0,),
              const SizedBox(height: 20.0,),
              Text(message),
            ],
          ),),
          deleteUserSuccess: (message) => Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 50.0,),
              const SizedBox(height: 20.0,),
              Text(message),
            ],
          ),),
        ),
      ),
    );
  }
}

class LogOutInitialPage extends StatelessWidget {
  const LogOutInitialPage({
    super.key,
    required TextEditingController userEmail,
    required TextEditingController userPassword,
    required UserAuthCubit authCubit,
  }) : _userEmail = userEmail, _userPassword = userPassword, _authCubit = authCubit;

  final TextEditingController _userEmail;
  final TextEditingController _userPassword;
  final UserAuthCubit _authCubit;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: CustomTextFormField(controller: _userEmail, hintText: 'E-mail', obscureText: false,)
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: CustomTextFormField(controller: _userPassword, hintText: 'Password', obscureText: true,),
              ),
              // const SizedBox(height: 20.0,),
              // InkWell(onTap: (){}, child: const Text('Forgot password?', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),)),
              const SizedBox(height: 30.0,),
              CupertinoButton(onPressed: (){
                _authCubit.loginWithEmail(userEmail: _userEmail.text, userPassword: _userPassword.text);
              }, color: Colors.black, child: const Text('Login'),),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: CupertinoButton(onPressed: (){
                  _authCubit.loginWithGoogle();
                },color: Colors.teal, child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(child: Image.network(
                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                          fit:BoxFit.cover
                      ),),
                      const Text('Login with Google'),
                    ],
                  ),
                ),),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No account: '),
            InkWell(onTap: (){
              _authCubit.registerInitialPage();
            }, child: const Text('Sign up', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),),),
          ],
        ),
        const SizedBox(height: 25.0,),

      ],
    ),);
  }
}

class SignUpUserPage extends StatelessWidget {
  final String uid;
  final TextEditingController userRegisterEmail;
  final TextEditingController userRegisterPassword;
  final TextEditingController userRepeatPassword;
  final UserAuthCubit cubit;
  const SignUpUserPage({
    required this.uid,
    required this.cubit,
    required this.userRepeatPassword,
    required this.userRegisterEmail,
    required this.userRegisterPassword,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Expanded(
              flex: 25,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: CustomTextFormField(controller: userRegisterEmail, hintText: 'E-mail', obscureText: false,)
                  ),
                  const SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: CustomTextFormField(controller: userRegisterPassword, hintText: 'Password', obscureText: true,),
                  ),
                  const SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: CustomTextFormField(controller: userRepeatPassword, hintText: 'Repeat password', obscureText: true,),
                  ),
                  const SizedBox(height: 30.0,),
                  CupertinoButton(onPressed: (){
                    cubit.registerWithEmailAndPassword(
                        passwordConfirmation: userRepeatPassword.text,
                        userEmail: userRegisterEmail.text,
                        userPassword: userRegisterPassword.text);
                  }, color: Colors.black, child: const Text('Register'),),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: CupertinoButton(onPressed: (){
                      cubit.registerWithGoogle();
                    },color: Colors.teal, child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(child: Image.network(
                              'http://pngimg.com/uploads/google/google_PNG19635.png',
                              fit:BoxFit.cover
                          ),),
                          const Text('Register with Google'),
                        ],
                      ),
                    ),),
                  ),
                ],
              ),
            ),
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have account: '),
                  InkWell(onTap: (){
                    cubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: uid);
                  }, child: const Text('Sign in', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),),),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),

          ],
        ),
    );
  }
}

class LogInInitialPage extends StatelessWidget {
  final List<SkateSpot> favSpots;
  final MyUser user;
  final UserAuthCubit cubit;
  const LogInInitialPage({super.key, required this.cubit, required this.user, required this.favSpots});

  @override
  Widget build(BuildContext context) {

    final _memoryData = GetStorage();

    return Column(
      children: [
        Expanded(flex:3,
            child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                user.userAvatar.isNotEmpty?
                CircleAvatar(backgroundImage: MemoryImage(const Base64Decoder().convert(user.userAvatar)), radius: 60,):
                const CircleAvatar(radius: 60),
                IconButton(onPressed: () async{
                  final imageAvatar = await ChooseImageToDatabase().chooseImageFromGallery();
                  if(imageAvatar == null){
                    null;
                  }else{
                    await cubit.changeUserCredentials(
                        userID: user.userID, credential: 'userAvatar', newCredentialValue: imageAvatar!);
                    cubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: user.userID);
                  }
                }, icon: const Icon(Icons.change_circle_sharp, size: 40,))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                user.userName.isNotEmpty? Text(user.userName, style: const TextStyle(fontSize: 20),):
                const Text('No name user'),
                InkWell(child: const Text('change display name',
                  style: TextStyle(fontSize: 12.0, color: Colors.teal),), onTap: (){
                  changeNameDialogBox(user: user, context: context);
                }),
              ],
            ),
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('MY FAV SPOTS', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w100),),
            const SizedBox(width: 20,),
            Icon(Icons.circle, color: _memoryData.read('userRiding') == true? Colors.green : Colors.red),
            GestureDetector(
              onTap: (){
                final spotID = _memoryData.read('userExistingSpot');
                if(spotID != ''){
                  context.pushNamed('spot_details_page', pathParameters: {'spotID': spotID, 'uid': user.userID});
                }
              },
                child: Text(_memoryData.read('userRiding') == true? 'Riding here' : 'Not riding')),
          ],
        ),
        Expanded(
          flex:7,
          child: favSpots.isNotEmpty? ListView.builder(
            itemCount: favSpots.length,
              itemExtent: 180,
              itemBuilder: (BuildContext context, int index){
              final spot = favSpots[index];
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: (){
                      context.pushNamed('spot_details_page', pathParameters: {'uid': user.userID, 'spotID': spot.spotID});
                    },
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(backgroundImage: MemoryImage(const Base64Decoder().convert(spot.spotPhotos[0])),radius: 70,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RatingBarIndicator(
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              rating: spot.spotRanks.sum / spot.spotRanks.length,
                              itemCount: 5,
                              itemSize: 40,
                            ),
                            Text(spot.spotName.toUpperCase(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
                IconButton(onPressed: () async{
                   await cubit.removeSpotFromFav(user: user, spotID: spot.spotID, spots: favSpots);
                   cubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: user.userID);
                }, icon: const Icon(Icons.delete_outline, size: 40,))
              ],
            );
          }): const Center(child: Text('No favourite spots'),),
        ),
        Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoButton(onPressed: (){
              cubit.logOutUser();
            }, color: Colors.black, child: const Text('Logout'),),
            CupertinoButton(onPressed: (){
              deleteUserConfirmation(user: user, context: context, cubit: cubit);
            }, color: Colors.black, child: const Text('Remove my account'),),
          ],
        ),),
        const SizedBox(height: 10.0,),
      ],
    );
  }

  changeNameDialogBox({required MyUser user, required BuildContext context}) async{
    showDialog(context: context, builder: (BuildContext context){

      final userNewName = TextEditingController();

      return AlertDialog(
        title: const Center(child: Text('Change Your name')),
        content: SizedBox(width: 350, height: 150, child: Center(
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNewName, hintText: user.userName, obscureText: false,),
              const SizedBox(height: 40.0,),
              CupertinoButton(onPressed: () async{
                await cubit.changeUserCredentials(userID: user.userID, credential: 'userName', newCredentialValue: userNewName.text);
                cubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: user.userID);
                if(context.mounted){
                  context.pop();
                }
              }, color: Colors.black,child: const Text('Change'),),
            ],
          ),
        ),),
      );
    });
  }

  deleteUserConfirmation({required MyUser user, required BuildContext context, required UserAuthCubit cubit}) async{
    showDialog(context: context, builder: (BuildContext context){
      final confirmationPassword = TextEditingController();
      return AlertDialog(
        title: const Center(child: Text('Confirmation'),),
        content: SizedBox(width: 350, height: 120, child: Column(
          children: [
            const Text('Do You really want to delete account? '),
            const SizedBox(height: 20.0,),
            CupertinoButton(child: Text('Delete account'), onPressed: () async{
              context.pop();
              cubit.deleteUser(userID: user.userID);
            }, color: Colors.black,),
          ],
        ),),
      );
    });
  }

}




