abstract class ImagePickerEvent {}

class PickImageInitial extends ImagePickerEvent {}

class PickImage extends ImagePickerEvent {}

class RemovePickedImage extends ImagePickerEvent {
  final List pickedImagesList;
  final int index;

  RemovePickedImage({required this.index, required this.pickedImagesList});
}

class FetchImages extends ImagePickerEvent {}
