import 'package:community_helpboard/features/posts/domain/services/i_image_picker_service.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> pickImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        return picked.path;
      } else {
        throw Exception('Failed to get pick image..');
      }
    } catch (e) {
      throw Exception('Failed to get pick image..');
    }
  }
}
