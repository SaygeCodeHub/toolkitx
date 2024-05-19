abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class PickingImage extends ImagePickerState {}

class ImagePicked extends ImagePickerState {
  final List pickedImagesList;
  final int imageCount;
  final String clientId;

  ImagePicked(
      {required this.clientId,
      required this.imageCount,
      required this.pickedImagesList});
}

class FailedToPickImage extends ImagePickerState {
  final String errText;

  FailedToPickImage({required this.errText});
}

class ImagesFetched extends ImagePickerState {
  final List images;
  final int imageCount;
  final String clientId;

  ImagesFetched(
      {required this.imageCount, required this.images, required this.clientId});
}
