import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants/string_constants.dart';
import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _imagePicker = ImagePicker();
  List<String> pickedImagesList = [];
  bool isCamera = false;
  int incrementImageCount = 0;

  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImageInitial>(_pickImageInitial);
    on<PickImage>(_pickImage);
    on<RemovePickedImage>(_removeImage);
  }

  FutureOr<void> _pickImageInitial(
      PickImageInitial event, Emitter<ImagePickerState> emit) {
    emit(ImagePickerInitial());
  }

  FutureOr<void> _pickImage(
      PickImage event, Emitter<ImagePickerState> emit) async {
    try {
      Future<bool> handlePermission() async {
        final permissionStatus = (isCamera == true)
            ? await Permission.camera.request()
            : await Permission.storage.request();
        if (permissionStatus == PermissionStatus.denied) {
          openAppSettings();
        } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
          emit(FailedToPickImage(errText: StringConstants.kPermissionsDenied));
        }
        return true;
      }

      final hasPermission = await handlePermission();
      if (!hasPermission) {
        return;
      } else {
        final pickedFile = await _imagePicker.pickImage(
            source:
                (isCamera == true) ? ImageSource.camera : ImageSource.gallery,
            imageQuality: 25);
        if (pickedFile != null) {
          if (pickedImagesList.length > 5) {
            emit(
                FailedToPickImage(errText: 'Can\'t upload more that 6 images'));
          } else {
            pickedImagesList.add(pickedFile.path);
            incrementImageCount++;
          }
          print('list------>$pickedImagesList');
          emit(ImagePicked(
              pickedImagesList: pickedImagesList,
              imageCount: incrementImageCount));
        }
      }
    } catch (e) {}
  }

  FutureOr<void> _removeImage(
      RemovePickedImage event, Emitter<ImagePickerState> emit) async {
    if (event.index >= 0 && event.index < pickedImagesList.length) {
      pickedImagesList.removeAt(event.index);
      incrementImageCount--;
      print('remove list----->$pickedImagesList');
      emit(ImagePicked(
          pickedImagesList: pickedImagesList, imageCount: incrementImageCount));
    }
  }
}
