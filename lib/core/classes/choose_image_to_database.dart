import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageToDatabase{
  ImagePicker _imagePicker = ImagePicker();
  // String imageUrl = '';

  Future<String?> chooseImageFromGallery() async{
    XFile? file = await _imagePicker.pickImage(
      maxHeight: 200,
        maxWidth: 200,
        source: ImageSource.gallery);
      if (file != null) {
        final bytes = File(file.path).readAsBytesSync();
        final picture = base64.encode(bytes);
        return picture;
    }else{
      return null;
    }
  }

  Future<List<String>> chooseManyImageFromGallery() async{
    List<String> myGallery = [];
    List<XFile?> gallery = await _imagePicker.pickMultiImage(
        maxHeight: 200,
        maxWidth: 200);
    if (gallery.isNotEmpty) {
      for(var item in gallery){
        final bytes = File(item!.path).readAsBytesSync();
        final picture = base64.encode(bytes);
        myGallery.add(picture);
      }

      return myGallery;
    }else{
      return [];
    }
  }

  Future<String?> chooseImageFromCamera() async{
    XFile? file = await _imagePicker.pickImage(
        maxHeight: 200,
        maxWidth: 200,
        source: ImageSource.camera);
    if (file != null) {
      final bytes = File(file.path).readAsBytesSync();
      final picture = base64.encode(bytes);
      return picture;
    }else{
      return null;
    }
  }
}