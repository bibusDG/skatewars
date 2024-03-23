import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_spot_map_bloc/add_spot_map_cubit.dart';

class AddSkateSpotMapPage extends HookWidget {
  final ValueNotifier<String> skateSpotLang;
  final ValueNotifier<String> skateSpotLat;
  const AddSkateSpotMapPage({super.key, required this.skateSpotLat, required this.skateSpotLang});

  @override
  Widget build(BuildContext context) {

    final _positionLoaded = useState('init');
    final _mapCubit = useBloc<AddSpotMapCubit>();
    final _mapState = useBlocBuilder(_mapCubit);
    useBlocListener<AddSpotMapCubit, AddSpotMapState>(_mapCubit, (bloc, current, context) { });

    useEffect((){
      _mapCubit.initMap();
      return null;
    },
      [_mapCubit],
    );

        return Column(
          children: [
            Expanded(
              flex: 4,
              child: _mapState.maybeWhen(
                mapLoaded: (position) {
                  final markers = <Marker>[
                    Marker(
                      point: LatLng(position.latitude, position.longitude),
                      rotate: false, child: const Icon(Icons.location_pin, color: Colors.red,size: 80,),
                    ),
                  ];
                  return FlutterMap(
                    options: MapOptions(
                      initialZoom: 20.0,
                      initialCenter: LatLng(position.latitude,position.longitude),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(markers: markers),
                      // MarkerLayer(markers: markers),
                    ],
                  );
                },
                  mapIsLoading: () => const Center(child: CircularProgressIndicator(),),
                  mapError: (message) => Center(child: Text(message),),
                  orElse: () => const Center(child: Text('Error'),),
              )

            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: CupertinoButton(
                        color: _positionLoaded.value == 'loaded'? Colors.green :
                        _positionLoaded.value == 'error'? Colors.red : Colors.black,
                        onPressed: () async{
                          final position = await _mapCubit.getUserPosition();
                          if(position != null){
                            _positionLoaded.value = 'loaded';
                            skateSpotLat.value = position.latitude.toString();
                            skateSpotLang.value = position.longitude.toString();
                            await Future.delayed(const Duration(seconds: 2));
                            if(context.mounted){
                              context.pop();
                            }
                          }else{
                            _positionLoaded.value = 'error';
                          }
                          // print(position.longitude);
                          // print(position.latitude);
                        },
                        child: _positionLoaded.value == 'loaded' ?
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline_outlined),
                            Text('Position saved'),
                          ],
                        ) :
                        _positionLoaded.value == 'error' ?
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_outlined),
                            Text('Something went wrong.'),
                          ],
                        ):
                        const Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Use this position and save'),
                          ],
                        )
                    ),
                  ),
                  CupertinoButton(color: Colors.black, onPressed: () {

                  }, child: const Text('Mark skate spot and save')),
                ],
              ),
            ),
          ],
        );
          // Container(height: 600, width: double.infinity, color: Colors.red,);
      }
}
