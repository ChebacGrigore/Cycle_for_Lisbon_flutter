import 'package:image_picker/image_picker.dart';

class MediaService {
  Future<String?> pickImage() async {
    String? path;
    ImagePicker picker = ImagePicker();
    XFile? result = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (result != null) {
      path = result.path;
    }
    return path;
  }
}
