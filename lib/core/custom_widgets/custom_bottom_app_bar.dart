import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skatewars/core/constants/constants.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: (){
          context.goNamed('show_skate_spots_page');
        }, icon: const Icon(Icons.list, size: 40,)),
        IconButton(onPressed: (){
          context.goNamed('add_skate_spot_page');
        }, icon: const Icon(Icons.add, size: 40,)),
        IconButton(onPressed: (){
          context.goNamed('start_page');
        }, icon: const Icon(Icons.link, size: 40,)),
        IconButton(onPressed: (){
          context.goNamed('login_page', pathParameters: {'userLoggedIn' : USER_LOGGED_IN.toString()});
        }, icon: const Icon(Icons.person, size: 40,)),



      ],
    ),);
  }
}