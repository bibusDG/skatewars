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

    final _newMarkerPosition = useState<LatLng>(const LatLng(0, 0));
    final _newSpotPosition = useState(false);
    final _positionLoaded = useState('init');


    final _mapCubit = useBloc<AddSpotMapCubit>();
    final _mapState = useBlocBuilder(_mapCubit);
    useBlocListener<AddSpotMapCubit, AddSpotMapState>(_mapCubit, (bloc, current, context) {});

    useEffect(
      () {
        _mapCubit.initMap();
        return null;
      },
      [_mapCubit],
    );

    return Column(
      children: [
        Expanded(
            flex: 5,
            child: _mapState.maybeWhen(
              mapLoaded: (position) {
                final markers = <Marker>[
                  Marker(
                    width: 80,
                    height: 80,
                    point: LatLng(position.latitude, position.longitude),
                    rotate: false,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 80,
                    ),
                  ),
                ];
                return FlutterMap(
                  options: MapOptions(
                    onTap: (tapPosition, point) {
                      _mapCubit.geNewPosition(point);
                    },
                    initialZoom: 19.0,
                    initialCenter: LatLng(position.latitude, position.longitude),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: markers),
                  ],
                );
              },
              newPosition: (newPosition) {
                final markers = <Marker>[
                  Marker(
                    width: 80,
                    height: 80,
                    alignment: Alignment.topCenter,
                    point: newPosition,
                    rotate: false,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 80,
                    ),
                  ),
                ];
                return FlutterMap(
                  options: MapOptions(
                    onTap: (tapPosition, point) {
                      _positionLoaded.value = 'init';
                      _newSpotPosition.value = true;
                      _mapCubit.geNewPosition(point);
                      _newMarkerPosition.value = point;
                    },
                    initialZoom: 19.0,
                    initialCenter: newPosition,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: markers,),
                  ],
                );
              },
              mapIsLoading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              mapError: (message) => Center(
                child: Text(message),
              ),
              orElse: () => const Center(
                child: Text('Error'),
              ),
            )),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Use existing position, or tap somewhere else and save.'),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: CupertinoButton(
                  pressedOpacity: 0.7,
                    color: _positionLoaded.value == 'loaded'
                        ? Colors.green
                        : _positionLoaded.value == 'error'
                            ? Colors.red
                            : Colors.black,
                    onPressed : () async {
                      if (_newSpotPosition.value == false) {
                        final position = await _mapCubit.getUserPosition();
                        if (position != null) {
                          _positionLoaded.value = 'loaded';
                          skateSpotLat.value = position.latitude.toString();
                          skateSpotLang.value = position.longitude.toString();
                          await Future.delayed(const Duration(seconds: 2));
                          if (context.mounted) {
                            context.pop();
                          }
                        } else {
                          _positionLoaded.value = 'error';
                        }
                      } else {
                        _positionLoaded.value = 'loaded';
                        skateSpotLat.value = _newMarkerPosition.value.latitude.toString();
                        skateSpotLang.value = _newMarkerPosition.value.longitude.toString();
                        await Future.delayed(const Duration(seconds: 2));
                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    },
                    child: _positionLoaded.value == 'loaded'
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline_outlined),
                              Text('Position saved'),
                            ],
                          )
                        : _positionLoaded.value == 'error'
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline_outlined),
                                  Text('Something went wrong.'),
                                ],
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Use this position and save'),
                                ],
                              )),
              ),
              // CupertinoButton(color: Colors.black, onPressed: () {
              //
              // }, child: const Text('Mark skate spot and save')),
            ],
          ),
        ),
      ],
    );
    // Container(height: 600, width: double.infinity, color: Colors.red,);
  }
}
