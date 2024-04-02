import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

class ImageOperations{

  Future<String> changeHttpImageToBase64({required String imageUrl}) async{
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
    }
  }