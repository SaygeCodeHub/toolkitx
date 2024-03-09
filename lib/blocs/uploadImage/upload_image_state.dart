abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadingImage extends UploadImageState {}

class ImageUploaded extends UploadImageState {
  final List images;

  ImageUploaded({required this.images});
}

class ImageCouldNotUpload extends UploadImageState {
  final String errorMessage;

  ImageCouldNotUpload({required this.errorMessage});
}
