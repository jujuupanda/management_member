import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'utils.dart';

class PickImage {
  final ImagePicker imagePicker = ImagePicker();

  pickImage(ImageSource source) async {
    try {
      // Pilih gambar
      final XFile? pickedFile = await imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Edit Foto",
            toolbarColor: PaletteColor().softBlack,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
          ),
        ],
      );
      if (croppedFile != null) {
        return croppedFile.readAsBytes();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

// upload image ke storage firebase
// uploadImageToStorage(
//     String folderName, String childName, Uint8List file) async {
//   Reference ref = _storageFirebase.ref(folderName).child(childName);
//   UploadTask uploadTask = ref.putData(file);
//   TaskSnapshot snapshot = await uploadTask;
//   String downloadedUrl = await snapshot.ref.getDownloadURL();
//   return downloadedUrl;
// }
}
