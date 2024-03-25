import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart';

class ShowSkateSpotsPage extends HookWidget {
  const ShowSkateSpotsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _showSkateSpotsCubit = useBloc<ShowSkateSpotsCubit>();
    final _showSkateSpotState = useBlocBuilder(_showSkateSpotsCubit);

    useEffect((){
      _showSkateSpotsCubit.showSkateSpotsInArea(distance: '2000');
    });

    return Scaffold(
      appBar: AppBar(title: Text('Show skate spots'),
      ),
      body: _showSkateSpotState.whenOrNull(
        showSpotsInitial: (listOfSpots) => ListView.builder(
          itemCount: listOfSpots.length,
          itemExtent: 150,
          itemBuilder: (BuildContext context, int index) {
            SkateSpot skateSpot = listOfSpots[index];
            return Card(
              child: Center(child: Text(skateSpot.spotName)),
            );
          },)
      ),
    );
  }
}
