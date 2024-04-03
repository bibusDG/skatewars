import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
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
        }
      );
    });

    useActionListener(_authCubit, (action){
      action.whenOrNull(
        loginActionMessage: (message) => CustomSnackBar().mySnackBar(context, message),
        signInActionMessage: (message) => CustomSnackBar().mySnackBar(context, message),
      );
    });

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(uid: uid),
      appBar: AppBar(title: Text('USER LOGIN PAGE'),
      ),
      body: _authState.whenOrNull(
        userRegisterInitialPage: () => SignUpUserPage(
            cubit: _authCubit,
            userRepeatPassword: _userRepeatPassword,
            userRegisterEmail: _userRegisterEmail,
            userRegisterPassword: _userRegisterPassword,
            uid: uid,
        ),
        userLoggedInInitialPage: (user) => LogInInitialPage(cubit: _authCubit, user: user),
        userLoggedOutInitialPage:() => LogOutInitialPage(userEmail: _userEmail, userPassword: _userPassword, authCubit: _authCubit),
        loginSuccess: (message, uid) => Center(child: Text(message),),
        loginInProgress: () => const Center(child: CircularProgressIndicator(),),
        loginFailed: (message) => Center(child: Text(message),),
        loginPageLoading: () => const Center(child: CircularProgressIndicator(),),
        loggedOutSuccess: (message) => Center(child: Text(message),),
        loginPageError: (message) => Center(child: Text(message)),
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
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: CustomTextFormField(controller: _userEmail, hintText: 'E-mail', obscureText: false,)
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: CustomTextFormField(controller: _userPassword, hintText: 'Password', obscureText: true,),
              ),
              const SizedBox(height: 20.0,),
              InkWell(onTap: (){}, child: const Text('Forgot password?', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),)),
              const SizedBox(height: 40.0,),
              CupertinoButton(onPressed: (){
                _authCubit.loginWithEmail(userEmail: _userEmail.text, userPassword: _userPassword.text);
              }, color: Colors.black, child: const Text('Login'),),
              const SizedBox(height: 70,),
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
        const SizedBox(height: 20.0,),

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
              child: Column(
                children: [
                  const SizedBox(height: 40,),
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
                  const SizedBox(height: 40.0,),
                  CupertinoButton(onPressed: (){
                    cubit.registerWithEmailAndPassword(userEmail: userRegisterEmail.text, userPassword: userRegisterPassword.text);
                  }, color: Colors.black, child: const Text('Register'),),
                  const SizedBox(height: 70,),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account: '),
                InkWell(onTap: (){
                  cubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString(), uid: uid);
                }, child: const Text('Sign in', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),),),
              ],
            ),
            const SizedBox(height: 20.0,),

          ],
        ),
    );
  }
}

class LogInInitialPage extends StatelessWidget {
  final MyUser user;
  final UserAuthCubit cubit;
  const LogInInitialPage({super.key, required this.cubit, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex:2,
            child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CircleAvatar(backgroundImage: MemoryImage(const Base64Decoder().convert(user.userAvatar)), radius: 60,),
                IconButton(onPressed: (){}, icon: Icon(Icons.change_circle_sharp, size: 40,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.userName, style: const TextStyle(fontSize: 20),),
              ],
            ),
            // const Text('BATTLES AND POINTS', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Column(
            //       children: [
            //         Text('WON', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),),
            //         Text(user.skateWarsWon.toString(), style: TextStyle(fontSize: 40, color: Colors.green),),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text('LOST', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200)),
            //         Text(user.skateWarsLost.toString(), style: TextStyle(fontSize: 40, color: Colors.redAccent)),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text('POINTS', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200)),
            //         Text(user.skatePoints.toString(), style: TextStyle(fontSize: 40, color: Colors.orangeAccent)),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        )),
        const Text('MY SPOTS', style: TextStyle(fontSize: 30),),
        Expanded(
          flex:5,
          child: user.favouriteSpots.isNotEmpty? ListView.builder(
            itemCount: user.favouriteSpots.length,
              itemExtent: 80,
              itemBuilder: (BuildContext context, int index){

            return Card();
          }): Center(child: Text('No favourite spots'),),
        ),
        Center(child: CupertinoButton(onPressed: (){
          cubit.logOutUser();
        }, child: const Text('LogOut'),
        ),),
      ],
    );
  }
}




