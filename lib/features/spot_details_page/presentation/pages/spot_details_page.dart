import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:skatewars/features/spot_details_page/presentation/bloc/spot_details_cubit.dart';

class SpotDetailsPage extends HookWidget {
  final String spotID;
  const SpotDetailsPage({super.key, required this.spotID});

  @override
  Widget build(BuildContext context) {

    final _spotDetailsCubit = useBloc<SpotDetailsCubit>();
    final _spotDetailsState = useBlocBuilder(_spotDetailsCubit);

    return Scaffold(
      appBar: AppBar(title: Text('SPOT DETAILS'),),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Card(color: Colors.deepOrange,)
      ),
    );
  }
}
