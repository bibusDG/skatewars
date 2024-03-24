import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:skatewars/features/add_skate_spot_page/presentation/pages/add_skate_spot_map_page.dart';

import '/../features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import '../../../../core/custom_widgets/carousel.dart';

class AddSkateSpotPage extends HookWidget {
  const AddSkateSpotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _skateSpotName = useTextEditingController();
    final _skateSpotLat = useState('');
    final _skateSpotLang = useState('');
    final _skateSpotAttributes = useState<List<String>>([]);

    final _addSkateSpotCubit = useBloc<AddSkateSpotCubit>();
    final _addSkateSpotState = useBlocBuilder(_addSkateSpotCubit);
    useBlocListener<AddSkateSpotCubit, AddSkateSpotState>(_addSkateSpotCubit, (bloc, current, context) {});

    useEffect(
      () {
        _addSkateSpotCubit.initAddSkateSpotPage(userLoggedIn: true);
        return null;
      },
      [_addSkateSpotCubit],
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
                              _addSkateSpotCubit.getSkateSpotImages();
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
                  SpotPropertiesColumn(
                    skateSpotAttributes: _skateSpotAttributes,
                    skateSpotLong: _skateSpotLang,
                    skateSpotLat: _skateSpotLat,
                    skateSpotName: _skateSpotName,
                    cubit: _addSkateSpotCubit,
                  ),
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
                          IconButton(
                              onPressed: () {
                                _addSkateSpotCubit.initAddSkateSpotPage(userLoggedIn: true);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 40,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SpotPropertiesColumn(
                    skateSpotAttributes: _skateSpotAttributes,
                    skateSpotLat: _skateSpotLat,
                    skateSpotLong: _skateSpotLang,
                    skateSpotName: _skateSpotName,
                    cubit: _addSkateSpotCubit,
                  ),
                ],
              )),
    );
  }
}

class SpotPropertiesColumn extends StatelessWidget {
  const SpotPropertiesColumn({
    super.key,
    required TextEditingController skateSpotName,
    required this.cubit,
    required this.skateSpotLat,
    required this.skateSpotLong,
    required this.skateSpotAttributes,
  }) : _skateSpotName = skateSpotName;

  final TextEditingController _skateSpotName;
  final ValueNotifier<String> skateSpotLat;
  final ValueNotifier<String> skateSpotLong;
  final ValueNotifier<List<String>> skateSpotAttributes;
  final AddSkateSpotCubit cubit;

  @override
  Widget build(BuildContext context) {
    final List<String> attributesList = ['Rails', 'Banks', 'Stairs', 'Flat ground', 'Grinds', 'Park', 'Ramps', 'Street', 'SkatePark'];
    final _attributes = attributesList.map((attr) => MultiSelectItem(attr, attr)).toList();

    return Expanded(
      flex: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: CupertinoButton(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.gps_fixed,
                      size: 30,
                    ),
                    const Text('Spot location'),
                    skateSpotLong.value == ''
                        ? const SizedBox()
                        : const Icon(
                            Icons.check_circle_outline_outlined,
                            size: 30,
                            color: Colors.green,
                          )
                  ],
                ),
                onPressed: () {
                  skateSpotLong.value = '';
                  skateSpotLat.value = '';
                  showModalBottomSheet(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return AddSkateSpotMapPage(
                          skateSpotLat: skateSpotLat,
                          skateSpotLang: skateSpotLong,
                        );
                      });
                  // await showMap(context: context, cubit: cubit, skateSpotLat: skateSpotLat, skateSpotLong: skateSpotLong);
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SpotDetailsMultiChoice(attributes: _attributes, skateSpotAttributes: skateSpotAttributes),
          ),
          CupertinoButton(
              color: Colors.black,
              child: const Text('Create'),
              onPressed: () {
                cubit.addSkateSpot(
                    spotDescription: 'spotDescription',
                    spotLang: skateSpotLong.value,
                    spotLat: skateSpotLat.value,
                    spotName: 'dd',
                    spotPhotos: [],
                    spotProperties: skateSpotAttributes.value);
                print(skateSpotLat.value);
                print(skateSpotLong.value);
              }),
        ],
      ),
    );
  }
}

class SpotDetailsMultiChoice extends StatelessWidget {
  const SpotDetailsMultiChoice({
    super.key,
    required List<MultiSelectItem<String?>> attributes,
    required this.skateSpotAttributes,
  }) : _attributes = attributes;

  final List<MultiSelectItem<String?>> _attributes;
  final ValueNotifier<List<String>> skateSpotAttributes;

  @override
  Widget build(BuildContext context) {
    return MultiSelectChipField(
      // initialValue: [],
      chipColor: Colors.orange,
      textStyle: const TextStyle(color: Colors.black),
      items: _attributes,
      title: const Text(" Choose spot attributes"),
      headerColor: Colors.white.withOpacity(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.orange, width: 1.8),
      ),
      selectedChipColor: Colors.blue.withOpacity(0.5),
      selectedTextStyle: const TextStyle(color: Colors.white),
      onTap: (values) async{
        skateSpotAttributes.value = List<String>.from(values);
        print(skateSpotAttributes.value);
      },
    );
  }
}
