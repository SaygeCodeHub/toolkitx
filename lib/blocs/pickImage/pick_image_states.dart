import 'package:equatable/equatable.dart';

abstract class PickImageStates extends Equatable {
  const PickImageStates();

  @override
  List<Object> get props => [];
}

class PermissionInitial extends PickImageStates {}

class PickImageLoading extends PickImageStates {}

class ImagePickerLoaded extends PickImageStates {
  final bool isImageAttached;
  final List imagePathsList;
  final String imagePath;

  const ImagePickerLoaded(
      {required this.imagePath,
      required this.imagePathsList,
      required this.isImageAttached});

  @override
  List<Object> get props => [isImageAttached];
}

class ImagePickerError extends PickImageStates {
  final String errorMessage;

  const ImagePickerError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
