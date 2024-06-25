import 'dart:io';

import 'package:toolkit/repositories/uploadImage/upload_image_repository.dart';

import '../../data/models/uploadImage/upload_image_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class UploadImageRepositoryImpl extends UploadImageRepository {
  @override
  Future<UploadPictureModel> uploadImage(
      File imagePath, String hashCode) async {
    final response = await DioClient().multiPart(
        "${ApiConstants.baseUrl}commonfileupload/upload", imagePath, hashCode);
    return UploadPictureModel.fromJson(response);
  }
}
