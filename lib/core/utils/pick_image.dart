part of 'utils.dart';

class PickImage {
  final ImagePicker _imagePicker = ImagePicker();

  pickImageSquare(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
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

  pickMultiImageFourThree() async {
    try {
      final List<XFile?> pickedMultiFile = await _imagePicker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedMultiFile.isEmpty) return [];

      final List<File> croppedFiles = [];

      for (var file in pickedMultiFile) {
        if (file == null) continue;

        final croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 90,
          aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
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
          croppedFiles.add(File(croppedFile.path));
        }
      }
      return croppedFiles;
    } catch (e) {
      throw Exception(e);
    }
  }

  pickImageAndUpload(String folderName) async {
    final file = await PickImage().pickImageSquare(ImageSource.gallery);
    if (file != null) {
      final stringUrlImage =
          DatabaseService().uploadImageToStorage(folderName, file);
      return stringUrlImage;
    }
    return null;
  }

  Future<String> uploadImage(File file, String folderName) async {
    final stringUrlImage =
        await DatabaseService().uploadImageToStorage(folderName, file);
    return stringUrlImage;
  }
}
