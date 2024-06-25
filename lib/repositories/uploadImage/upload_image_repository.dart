import 'dart:io';

import '../../data/models/uploadImage/upload_image_model.dart';

abstract class UploadImageRepository {
  Future<UploadPictureModel> uploadImage(File imagePath, String hashCode);
}
