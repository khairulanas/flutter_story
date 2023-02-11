import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_story/src/core/common/failure.dart';
import 'package:flutter_story/src/core/data/model/common_response.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:image/image.dart' as img;

class UploadProvider extends ChangeNotifier {
  final Repository apiService;

  UploadProvider(this.apiService);

  bool isUploading = false;
  String message = "";
  bool isError = false;
  CommonResponse? uploadResponse;

  Future<void> upload(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    message = "";
    uploadResponse = null;
    isUploading = true;
    isError = false;
    notifyListeners();

    Either<Failure, CommonResponse> failOrSuccess =
        await apiService.addNewStory(
            description: description, photoBytes: bytes, fileName: fileName);
    failOrSuccess.fold((l) {
      isUploading = false;
      message = l.message;
      isError = true;
      notifyListeners();
    }, (r) {
      uploadResponse = r;
      message = uploadResponse?.message ?? "success";
      isUploading = false;
      isError = false;
      notifyListeners();
    });
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }

  Future<List<int>> resizeImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    bool isWidthMoreTaller = image.width > image.height;
    int imageTall = isWidthMoreTaller ? image.width : image.height;
    double compressTall = 1;
    int length = imageLength;
    List<int> newByte = bytes;

    do {
      compressTall -= 0.1;

      final newImage = img.copyResize(
        image,
        width: isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
        height: !isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
      );

      length = newImage.length;
      if (length < 1000000) {
        newByte = img.encodeJpg(newImage);
      }
    } while (length > 1000000);

    return newByte;
  }

  String? imagePath;

  XFile? imageFile;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void clean() {
    imagePath = null;
    imageFile = null;
    message = "";
    uploadResponse = null;
  }
}
