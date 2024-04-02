import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/core/custom_widgets/custom_bottom_app_bar.dart';
import 'package:skatewars/features/user_relations/presentation/bloc/user_auth_cubit.dart';

import '../../../../core/custom_widgets/custom_text_form_field.dart';

class UserLoginPage extends HookWidget {
  final String userLoggedIn;
  const UserLoginPage({super.key, required this.userLoggedIn});

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
      _authCubit.loginInitialPage(userLoggedIn: userLoggedIn);
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
            _authCubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString());
          }
        }
      );
    });

    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(uid: 'dd',),
      appBar: AppBar(title: Text('USER LOGIN PAGE'),
      ),
      body: _authState.whenOrNull(
        userRegisterInitialPage: () => SignUpUserPage(cubit: _authCubit, userRepeatPassword: _userRepeatPassword, userRegisterEmail: _userRegisterEmail, userRegisterPassword: _userRegisterPassword),
        userLoggedInInitialPage: () => Center(child: CupertinoButton(onPressed: (){
          _authCubit.logOutUser();
        }, child: const Text('LogOut'),),),
        userLoggedOutInitialPage:() => LogInInitialPage(userEmail: _userEmail, userPassword: _userPassword, authCubit: _authCubit),
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

class LogInInitialPage extends StatelessWidget {
  const LogInInitialPage({
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
  final TextEditingController userRegisterEmail;
  final TextEditingController userRegisterPassword;
  final TextEditingController userRepeatPassword;
  final UserAuthCubit cubit;
  const SignUpUserPage({
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
                  cubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString());
                }, child: const Text('Sign in', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),),),
              ],
            ),
            const SizedBox(height: 20.0,),

          ],
        ),
    );
  }
}



