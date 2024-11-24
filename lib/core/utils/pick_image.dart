part of 'utils.dart';

class PickImage {
  final ImagePicker imagePicker = ImagePicker();

  pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return null;

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
        return File(croppedFile.path);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  pickImageAndUpload(String folderName) async {
    final file = await PickImage().pickImage(ImageSource.gallery);
    if (file != null) {
      final stringUrlImage =
          DatabaseService().uploadImageToStorage(folderName, file);
      return stringUrlImage;
    }
    return null;
  }

  uploadImage(File file, String folderName) {
    final stringUrlImage =
        DatabaseService().uploadImageToStorage(folderName, file);
    return stringUrlImage;
  }
}
