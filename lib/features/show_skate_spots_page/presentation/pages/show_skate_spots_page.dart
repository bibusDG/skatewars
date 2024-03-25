import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ShowSkateSpotsPage extends HookWidget {
  const ShowSkateSpotsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showSkateSpotsCubit = useBloc<ShowSkateSpotsCubit>();
    final _showSkateSpotState = useBlocBuilder(_showSkateSpotsCubit);
    final _distance = useState('10000');
    final _showAll = useState(false);

    useEffect(() {
      _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Show skate spots'),
      ),
      body:Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: _showSkateSpotState.maybeWhen(
                      showSpotsInitial:(listOfSpots) => ListView.builder(
                        itemCount: listOfSpots.length,
                        itemExtent: 180,
                        itemBuilder: (BuildContext context, int index) {
                          SkateSpot skateSpot = listOfSpots[index];
                          // final skateSpotRating = skateSpot.spotRanks.sum;
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.tealAccent,
                                    backgroundImage: skateSpot.spotPhotos.isEmpty
                                        ? null
                                        : Image.memory(const Base64Decoder().convert(skateSpot.spotPhotos[0])).image,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(
                                          child: Text(
                                            skateSpot.spotName.toUpperCase(),
                                            style: const TextStyle(fontSize: 25),
                                          )),
                                      RatingBarIndicator(
                                        itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        rating: skateSpot.spotRanks.sum / skateSpot.spotRanks.length,
                                        itemCount: 5,
                                        itemSize: 40,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            size: 40,
                                            color: Colors.white70,
                                          ),
                                          Text(
                                            ' : ${skateSpot.spotRiders.length}',
                                            style: const TextStyle(fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      showSpotsPageLoading: () => const Center(child: CircularProgressIndicator(),),
                      showSpotsPageEmpty: (message) => const Center(child: Text('We havent found any spots.'),),
                      orElse: () => const Center(child: Text('error'),)),
                  ),
                  SizedBox( child:
                  _showSkateSpotState.maybeWhen(
                    showSpotsPageLoading: () => null,
                    showSpotsPageError: (message) => null,
                    orElse:() => _showAll.value == false
                      ? Column(
                    children: [
                      const Text('Find spot in Your area by moving below slider'),
                      const SizedBox(height: 20.0,),
                      SfSliderTheme(
                        data: const SfSliderThemeData(
                            tooltipBackgroundColor: Colors.orangeAccent,
                            tooltipTextStyle: TextStyle(color: Colors.black)
                        ),
                        child: SfSlider(
                            inactiveColor: Colors.white70,
                            activeColor: Colors.teal,
                            minorTicksPerInterval: 10,
                            showLabels: true,
                            interval: 100,
                            stepSize: 1,
                            enableTooltip: true,
                            tooltipShape: const SfPaddleTooltipShape(),
                            min: 0.0,
                            max: 500.0,
                            value: double.parse(_distance.value)/1000,
                            numberFormat: NumberFormat("km "),
                            onChanged: (value) {
                              _distance.value = (value*1000).toString();
                              _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value);
                            }),
                      ),
                      const SizedBox(height: 20.0,),
                      CupertinoButton(
                        onPressed: () {
                          _showAll.value = true;
                          _distance.value = '10000000';
                          _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value);
                        },
                        color: Colors.black,
                        child: const Text('Show all'),
                      ),
                    ],
                  )
                      : CupertinoButton(
                    onPressed: () {
                      _showAll.value = false;
                      _distance.value = '50000';
                    },
                    color: Colors.black,
                    child: const Text('Distance'),
                  ),),
                  ),
                  const SizedBox(height: 20.0,),
                ],
              ),
    );
  }
}
