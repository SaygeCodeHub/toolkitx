abstract class UploadImageEvent {}

class UploadImage extends UploadImageEvent {
  final List images;
  final int imageLength;

  UploadImage({required this.imageLength, required this.images});
}
