
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/core/custom_widgets/carousel.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/spot_details_page/presentation/bloc/spot_details_cubit.dart';
import 'package:collection/collection.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';

import '../../../../core/custom_widgets/custom_bottom_app_bar.dart';

class SpotDetailsPage extends HookWidget {
  final String spotID;
  final String uid;
  const SpotDetailsPage({super.key, required this.spotID, required this.uid});

  @override
  Widget build(BuildContext context) {
    final _spotDetailsCubit = useBloc<SpotDetailsCubit>();
    final _spotDetailsState = useBlocBuilder(_spotDetailsCubit);
    final _switch = useState(false);

    useEffect(() {
      _spotDetailsCubit.initSpotDetailPage(spotID: spotID);
      return null;
    },
      [_spotDetailsCubit],
    );

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(uid: uid,),
      appBar: AppBar(
        title: Text('SPOT DETAILS'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _spotDetailsState.whenOrNull(
          spotDetailsPageLoaded: (skateSpot, riders) => Card(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomCarouselSlider(gallery: skateSpot.spotPhotos,),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 2,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.comment,
                              size: 40,
                            ),
                            color: Colors.teal,
                          )),
                      Expanded(
                          flex: 6,
                          child: Center(
                              child: Text(
                            skateSpot.spotName.toUpperCase(),
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                          ))),
                      Expanded(
                          flex: 2,
                          child: IconButton(
                            onPressed: () {
                              final _ratingDialog = RatingDialog(
                                title: const Text(
                                  'Rate spot',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // encourage your user to leave a high rating?
                                message: const Text(
                                  'Tap a star to set your rating. Add some comments.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                                // your app's logo?
                                submitButtonText: 'Submit',
                                commentHint: 'Comment spot',
                                onSubmitted: (response) {},
                              );
                              showDialog(context: context, builder: (BuildContext context){
                                return _ratingDialog;
                              });
                            },
                            icon: const Icon(
                              Icons.star_rate_outlined,
                              size: 40,
                            ),
                            color: Colors.teal,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RatingBarIndicator(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    rating: skateSpot.spotRanks.sum / skateSpot.spotRanks.length,
                    itemCount: 5,
                    itemSize: 40,
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: SpotDetailMap(skateSpot: skateSpot,),
                                ))),
                        Expanded(
                            flex: 3,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Card(
                                      color: Colors.purple,
                                      child: ListView.builder(
                                        itemCount: riders.length,
                                          itemExtent: 80,
                                          itemBuilder: (BuildContext context, int index){
                                          MyUser user = riders[index];
                                        return Card(child:
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                            user.userAvatar.isNotEmpty? CircleAvatar(
                                              backgroundImage: MemoryImage(const Base64Decoder().convert(user.userAvatar)),):
                                            const CircleAvatar(),
                                            Text(user.userName)
                                          ],),);
                                      }),
                                    )),
                                CircleAvatar(child: Text(skateSpot.spotRiders.length.toString())),
                              ],
                            )),
                      ],
                    )),
                Expanded(flex: 1, child: Row(
                  children: [
                    Expanded(
                      flex:7,
                      child: ListView.builder(
                          itemExtent: 120,
                          itemCount: skateSpot.spotProperties.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index){
                            return Card(
                              color: Colors.teal,
                              child: Center(child: Text(skateSpot.spotProperties[index])),
                            );
                          }),
                    ),
                    Expanded(flex: 4, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("  I'm here "),
                        CupertinoSwitch(
                          activeColor: Colors.green,
                          trackColor: Colors.red,
                          value: _switch.value, onChanged: (bool value) async{
                          if(_switch.value && USER_LOGGED_IN){
                            _switch.value = false;
                            await _spotDetailsCubit.removeUserFromSpot(userID: uid, spotID: spotID);

                          }else if(USER_LOGGED_IN){
                            _switch.value = true;
                            await _spotDetailsCubit.addUserToSpot(spotID: spotID, userID: uid);

                          }
                        },),
                      ],
                    ))
                  ],
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpotDetailMap extends StatelessWidget {
  final SkateSpot skateSpot;
  const SpotDetailMap({
    super.key,
    required this.skateSpot
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialZoom: 15.0,
        initialCenter: LatLng(double.parse(skateSpot.spotLat), double.parse(skateSpot.spotLang)),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: [Marker(
          width: 80,
          height: 80,
          point: LatLng(double.parse(skateSpot.spotLat), double.parse(skateSpot.spotLang)),
          rotate: false,
          child: const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 50,
          ),
        ),]),
      ],
    );
  }
}
