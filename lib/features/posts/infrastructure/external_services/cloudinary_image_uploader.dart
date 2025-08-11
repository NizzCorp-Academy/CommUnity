import 'package:cloudinary/cloudinary.dart';
import 'package:community_helpboard/features/posts/domain/services/i_image_uploader_service.dart';

class CloudinaryImageUploader implements IImageUploaderService {
  @override
  Future<String?> uploadImage(String imagePath) async {
    try {
      final cloudinary = Cloudinary.unsignedConfig(cloudName: 'dj2msg181');
      final response = await cloudinary.unsignedUpload(
        file: imagePath,
        uploadPreset: 'flutter_upload',
        resourceType: CloudinaryResourceType.image,
        folder: 'uploads',
      );
      if (response.isSuccessful && response.secureUrl != null) {
        return response.secureUrl;
      } else {
        throw Exception('Failed to connect media..');
      }
    } catch (e) {
      throw Exception('Failed to upload media..');
    }
  }
}
