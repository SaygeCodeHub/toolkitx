import '../../data/models/uploadImage/upload_image_model.dart';

abstract class PickAndUploadImage {}

class UploadInitial extends PickAndUploadImage {}

class PickCameraImage extends PickAndUploadImage {
  final bool? isImageAttached;
  final List cameraImageList;
  final int? index;
  final bool isSignature;

  PickCameraImage(
      {this.isSignature = false,
      this.index,
      required this.cameraImageList,
      required this.isImageAttached});
}

class PickGalleryImage extends PickAndUploadImage {
  final bool? isImageAttached;
  final List galleryImagesList;
  final int? index;
  final bool isSignature;

  PickGalleryImage({
    this.isSignature = false,
    this.index,
    required this.isImageAttached,
    required this.galleryImagesList,
  });
}

class UploadImageEvent extends PickAndUploadImage {
  final String imageFile;
  final bool isImageAttached;
  final List imagesList;

  UploadImageEvent(
      {required this.imagesList,
      required this.isImageAttached,
      required this.imageFile});
}

class RemoveImage extends PickAndUploadImage {
  final List imagesList;
  final UploadPictureModel uploadPictureModel;
  final int index;

  RemoveImage(
      {required this.uploadPictureModel,
      required this.index,
      required this.imagesList});
}

class CropImage extends PickAndUploadImage {
  final String imagePath;

  CropImage({required this.imagePath});
}
