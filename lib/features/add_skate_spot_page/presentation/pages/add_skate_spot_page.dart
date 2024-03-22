import '/../features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/custom_widgets/carousel.dart';

class AddSkateSpotPage extends HookWidget {
  const AddSkateSpotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _skateSpotName = useTextEditingController();
    final _skateSpotLat = useState('');
    final _skateSpotLang = useState('');
    final _skateSpotAttributes = useState([]);

    final _addSkateSpotCubiit = useBloc<AddSkateSpotCubit>();
    final _addSkateSpotState = useBlocBuilder(_addSkateSpotCubiit);
    useBlocListener<AddSkateSpotCubit, AddSkateSpotState>(_addSkateSpotCubiit, (bloc, current, context) {});

    useEffect(
      () {
        _addSkateSpotCubiit.initAddSkateSpotPage(userLoggedIn: true);
        return null;
      },
      [_addSkateSpotCubiit],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding new spot'),
      ),
      body: _addSkateSpotState.whenOrNull(
          addSkateSpotPageLoading: () => const Center(child: CircularProgressIndicator()),
          addSkateSpotPageError: (message) => Center(
                child: Text(message),
              ),
          addSkateSpotPageLoaded: (userLoginIn) => Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.purple,
                            radius: 150,
                            child: Text(' PHOTO GALLERY '),
                          ),
                          IconButton(
                            onPressed: () {
                              _addSkateSpotCubiit.getSkateSpotImages();
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SpotPropertiesColumn(skateSpotName: _skateSpotName),
                ],
              ),
          gallery: (gallery) => Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              CustomCarouselSlider(
                        gallery: gallery,
                      ),
                              IconButton(onPressed: (){
                                _addSkateSpotCubiit.initAddSkateSpotPage(userLoggedIn: true);
                              }, icon: const Icon(Icons.delete_outline, size: 40,)),
                            ],
                          ),
                      ),
                  ),
                  SpotPropertiesColumn(skateSpotName: _skateSpotName),
                ],
              )),
    );
  }
}

class SpotPropertiesColumn extends StatelessWidget {
  const SpotPropertiesColumn({
    super.key,
    required TextEditingController skateSpotName,
  }) : _skateSpotName = skateSpotName;

  final TextEditingController _skateSpotName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: CupertinoButton(
                color: Colors.black,
                child: const Row(
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('Spot location'),
                  ],
                ),
                onPressed: () async{
                 await showMap(context);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  // (value) => departmentCubit.findDepartment(value),
                  controller: _skateSpotName,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3, color: Colors.redAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: const BorderSide(width: 5, color: Colors.white), borderRadius: BorderRadius.circular(20.0)),
                    // errorText: errorText,
                    // hintText: 'Spot name',
                    label: const Text('  Spot name '),
                    // icon: icon,
                  ),
                ),
              ),
            ),
          ),
          CupertinoButton(color: Colors.black, child: const Text('Attributes'), onPressed: () {}),
          CupertinoButton(color: Colors.black, child: const Text('Create'), onPressed: () {}),
        ],
      ),
    );
  }
  
  Future<void> showMap(context) async{
    showModalBottomSheet(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        context: context, builder: (BuildContext context){
      return Column(
        children: [
          Expanded(
            flex: 4,
            child: FlutterMap(
              options: const MapOptions(
                initialZoom: 3.2,
                initialCenter: LatLng(51.509364, 30.51),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(child: Text('Get my position and save'), onPressed: (){}),
                CupertinoButton(child: Text('Mark skate spot and save'), onPressed: (){}),
              ],
            ),
          ),
        ],
      );
    });
}
  
}
