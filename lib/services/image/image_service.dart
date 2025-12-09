import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// 갤러리에서 이미지 선택
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 카메라에서 이미지 촬영
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 이미지 선택 옵션 표시 (갤러리/카메라)
  Future<File?> pickImage({bool allowCamera = true}) async {
    // 실제로는 showDialog로 선택 옵션을 보여줘야 하지만
    // 여기서는 간단히 갤러리만 사용
    return await pickImageFromGallery();
  }

  /// 여러 이미지 선택
  Future<List<File>> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      return images.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      return [];
    }
  }
}

