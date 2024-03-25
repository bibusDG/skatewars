import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class StartPage extends HookWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(onPressed: (){
            context.pushNamed('add_skate_spot_page');
                      }, color: Colors.black,child: const Text('Add spot'),),
            CupertinoButton(onPressed: (){
              context.pushNamed('show_skate_spots_page');
            }, color: Colors.black,child: const Text('Show spots'),),
          ],
        ),
      ),
    );
  }
}
