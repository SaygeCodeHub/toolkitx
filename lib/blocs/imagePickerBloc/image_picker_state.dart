abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class PickingImage extends ImagePickerState {}

class ImagePicked extends ImagePickerState {
  final List<String> pickedImagesList;
  final int imageCount;

  ImagePicked({required this.imageCount, required this.pickedImagesList});
}

class FailedToPickImage extends ImagePickerState {
  final String errText;

  FailedToPickImage({required this.errText});
}
