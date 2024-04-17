import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../core/custom_widgets/custom_bottom_app_bar.dart';

class ShowSkateSpotsPage extends HookWidget {
  final String uid;
  const ShowSkateSpotsPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {

    final _userLoggedIn = USER_LOGGED_IN;

    final _showSkateSpotsCubit = useBloc<ShowSkateSpotsCubit>();
    final _showSkateSpotState = useBlocBuilder(_showSkateSpotsCubit);
    final _distance = useState('10000');
    final _showAll = useState(false);

    useEffect(() {
      _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value, userID: uid);
      return null;
    },
      [_showSkateSpotsCubit],
    );

    useActionListener(_showSkateSpotsCubit, (action){
      action.whenOrNull(
        addSpotDialogBox: (title, message) => showAddSpotDialog(title: title, message: message, context: context),
      );
    });

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(uid: uid,),
      appBar: AppBar(
        title: const Text('SKATE SPOTS', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
        actions: [
          _userLoggedIn? CircleAvatar(backgroundImage: _showSkateSpotState.whenOrNull(
            showSpotsInitial: (listOfSpots, userPosition, user) {
              if(user.userAvatar.isEmpty){
                return null;
              }else{
                return MemoryImage(const Base64Decoder().convert(user.userAvatar));
              }
            }
          )) : SizedBox(),
        ],
      ),
      body:Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: _showSkateSpotState.maybeWhen(
                      showSpotsInitial:(listOfSpots, userPosition, user) => ListView.builder(
                        itemCount: listOfSpots.length,
                        itemExtent: 200,
                        itemBuilder: (BuildContext context, int index) {
                          SkateSpot skateSpot = listOfSpots[index];
                          final distanceToSkateSpot = Geolocator.distanceBetween(
                              userPosition.latitude, userPosition.longitude,
                              double.parse(skateSpot.spotLat), double.parse(skateSpot.spotLang));
                          // final skateSpotRating = skateSpot.spotRanks.sum;
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    context.pushNamed('spot_details_page', pathParameters: {'spotID' : skateSpot.spotID, 'uid' : uid});
                                  },
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
                                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),
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
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_pin, size: 30, color: Colors.red,),
                                                    Text('${((distanceToSkateSpot/1000).toPrecision(2))} km'),
                                                  ],
                                                ),
                                                const SizedBox(width: 20.0,),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.person,
                                                      size: 30,
                                                      color: Colors.white70,
                                                    ),
                                                    Text(
                                                      ': ${skateSpot.spotRiders.length}',
                                                      style: const TextStyle(fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  if(USER_LOGGED_IN && !user.favouriteSpots.contains(skateSpot.spotID)){
                                    _showSkateSpotsCubit.addSpotToFavorites(userID: uid, spotID: skateSpot.spotID);
                                  }else if(USER_LOGGED_IN && user.favouriteSpots.contains(skateSpot.spotID)){
                                    showAddSpotDialog(title: 'Uppss....', message: 'Spot already in Your favs', context: context);
                                  }else{
                                    showAddSpotDialog(title: 'Upps...', message: 'To add spot to favs, you need to be logged in', context: context);
                                  }
                                }, icon: const Icon(Icons.favorite_border, size: 40, color: Colors.deepOrange,)),
                              ],
                            ),
                          );
                        },
                      ),
                      showSpotsPageLoading: () => const Center(child: CircularProgressIndicator(),),
                      showSpotsPageEmpty: (message) => const Center(child: Text("We haven't found any spots."),),
                      orElse: () => const Center(child: Text('We have some problems...\n'
                          'It seems, that You need to switch on location services.'),)),
                  ),
                  SizedBox( child:
                  _showSkateSpotState.maybeWhen(
                    showSpotsPageLoading: () => null,
                    showSpotsPageError: (message) => null,
                    orElse:() => _showAll.value == false
                      ? Column(
                    children: [
                      const SizedBox(height: 10.0,),
                      const Text('Find spot in Your nearest area by moving below slider.'),
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
                            interval: 20,
                            stepSize: 1,
                            enableTooltip: true,
                            tooltipShape: const SfPaddleTooltipShape(),
                            min: 0.0,
                            max: 100.0,
                            value: double.parse(_distance.value)/1000,
                            numberFormat: NumberFormat("km "),
                            onChanged: (value) {
                              _distance.value = (value*1000).toString();
                              _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value, userID: uid);
                            }),
                      ),
                      const SizedBox(height: 20.0,),
                      CupertinoButton(
                        onPressed: () {
                          _showAll.value = true;
                          _distance.value = '10000000';
                          _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value, userID: uid);
                        },
                        color: Colors.black,
                        child: const Text('Show all'),
                      ),
                    ],
                  )
                      : CupertinoButton(
                    onPressed: () {
                      _showAll.value = false;
                      _distance.value = '10000';
                      _showSkateSpotsCubit.showSkateSpotsInArea(distance: _distance.value, userID: uid);
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

  showAddSpotDialog({required String title, required String message, required BuildContext context}) async{
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Center(child: Text(title),),
        content: SizedBox(height: 50, width: 350, child: Center(child: Text(message)),)
      );
    });
  }

}
