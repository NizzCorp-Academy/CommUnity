import 'package:community_helpboard/features/posts/domain/services/i_image_uploader_service.dart';

class UploadImageUseCase {
  final IImageUploaderService imageUploader;

  UploadImageUseCase(this.imageUploader);

  Future<String?> call(String imagePath) async {
    return await imageUploader.uploadImage(imagePath);
  }
}
