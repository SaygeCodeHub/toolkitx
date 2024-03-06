import 'package:equatable/equatable.dart';

import '../../data/models/uploadImage/upload_image_model.dart';

abstract class PickAndUploadImageStates extends Equatable {}

class PermissionInitial extends PickAndUploadImageStates {
  @override
  List<Object?> get props => [];
}

class PickImageLoading extends PickAndUploadImageStates {
  @override
  List<Object?> get props => [];
}

class ImagePickerLoaded extends PickAndUploadImageStates {
  final bool isImageAttached;
  final List imagePathsList;
  final String imagePath;
  final int incrementNumber;
  final UploadPictureModel uploadPictureModel;

  ImagePickerLoaded(
      {required this.incrementNumber,
      required this.imagePath,
      required this.imagePathsList,
      required this.isImageAttached,
      required this.uploadPictureModel});

  @override
  List<Object> get props =>
      [isImageAttached, imagePathsList, imagePath, incrementNumber];
}

class ImagePickerError extends PickAndUploadImageStates {
  final String errorMessage;

  ImagePickerError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ImageNotUploaded extends PickAndUploadImageStates {
  final String imageNotUploaded;

  ImageNotUploaded({required this.imageNotUploaded});

  @override
  List<Object> get props => [];
}

class RemovePickedImage extends PickAndUploadImageStates {
  final bool isImageAttached;
  final List imagePathsList;
  final String imagePath;

  RemovePickedImage(
      {required this.isImageAttached,
      required this.imagePathsList,
      required this.imagePath});

  @override
  List<Object> get props => [isImageAttached, imagePathsList, imagePath];
}
