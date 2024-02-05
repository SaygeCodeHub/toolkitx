import 'dart:async';

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../configs/app_color.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/uploadImage/upload_image_model.dart';
import '../../di/app_module.dart';
import '../../repositories/uploadImage/upload_image_repository.dart';
import 'pick_and_upload_image_events.dart';
import 'pick_and_upload_image_states.dart';

class PickAndUploadImageBloc
    extends Bloc<PickAndUploadImage, PickAndUploadImageStates> {
  final UploadImageRepository _uploadPictureRepository =
      getIt<UploadImageRepository>();
  final ImagePicker _imagePicker = ImagePicker();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  bool isInitialUpload = true;
  int imageIndex = 0;

  PickAndUploadImageStates get initialState => PermissionInitial();

  PickAndUploadImageBloc() : super(PermissionInitial()) {
    on<UploadInitial>(_uploadInitial);
    on<PickCameraImage>(_pickCameraImage);
    on<PickGalleryImage>(_pickGalleryImage);
    on<UploadImageEvent>(_uploadImageEvent);
    on<RemoveImage>(_removeImage);
    on<CropImage>(_cropImage);
  }

  _uploadInitial(UploadInitial event, Emitter<PickAndUploadImageStates> emit) {
    isInitialUpload = true;
    imageIndex = 0;
    emit(PermissionInitial());
  }

  FutureOr<void> _pickCameraImage(
      PickCameraImage event, Emitter<PickAndUploadImageStates> emit) async {
    try {
      Future<bool> handlePermission() async {
        final cameraStatus = await Permission.camera.request();
        if (cameraStatus == PermissionStatus.denied) {
          openAppSettings();
        } else if (cameraStatus == PermissionStatus.permanentlyDenied) {
          emit(ImagePickerError(StringConstants.kPermissionsDenied));
        }
        return true;
      }

      final hasPermission = await handlePermission();
      if (!hasPermission) {
        return;
      } else {
        bool isImageAttached = false;
        List cameraPathsList =
            List.from((isInitialUpload == false) ? event.cameraImageList : []);
        imageIndex = isInitialUpload == true ? 0 : imageIndex;
        String imagePath = '';
        final pickedFile = await _imagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        isInitialUpload = false;
        emit(PickImageLoading());
        if (pickedFile != null) {
          isImageAttached = true;
          cameraPathsList.add(pickedFile.path);
          for (int i = 0; i < cameraPathsList.length; i++) {
            imagePath = cameraPathsList[i];
          }
          for (int i = 0; i <= cameraPathsList.length; i++) {
            imageIndex = i;
          }
          if (isImageAttached == true) {
            if (event.isSignature == true) {
              add(CropImage(imagePath: imagePath));
            } else {
              add(UploadImageEvent(
                  imageFile: imagePath,
                  isImageAttached: isImageAttached,
                  imagesList: cameraPathsList));
            }
          }
        } else {
          isImageAttached = false;
          add(UploadImageEvent(
              imageFile: '',
              isImageAttached: isImageAttached,
              imagesList: cameraPathsList));
        }
      }
    } catch (e) {
      emit(ImagePickerError(StringConstants.kFailedToCaptureImage));
    }
  }

  FutureOr<void> _pickGalleryImage(
      PickGalleryImage event, Emitter<PickAndUploadImageStates> emit) async {
    try {
      Future<bool> handlePermission() async {
        final galleryStatus = await Permission.storage.request();
        if (galleryStatus == PermissionStatus.denied) {
          openAppSettings();
        } else if (galleryStatus == PermissionStatus.permanentlyDenied) {
          emit(ImagePickerError(StringConstants.kPermissionsDenied));
        }
        return true;
      }

      final hasPermission = await handlePermission();
      if (!hasPermission) {
        return;
      } else {
        bool isImageAttached = false;
        List galleryPathsList = List.from(
            (isInitialUpload == false) ? event.galleryImagesList : []);
        imageIndex = isInitialUpload == true ? 0 : imageIndex;

        String imagePath = '';
        final pickedFile =
            await _imagePicker.pickImage(source: ImageSource.gallery);
        isInitialUpload = false;
        emit(PickImageLoading());
        if (pickedFile != null) {
          isImageAttached = true;
          galleryPathsList.add(pickedFile.path);
          for (int i = 0; i < galleryPathsList.length; i++) {
            imagePath = galleryPathsList[i];
          }
          for (int i = 0; i <= galleryPathsList.length; i++) {
            imageIndex = i;
          }
          if (isImageAttached == true) {
            if (event.isSignature == true) {
              add(CropImage(imagePath: imagePath));
            } else {
              add(UploadImageEvent(
                  imageFile: imagePath,
                  isImageAttached: isImageAttached,
                  imagesList: galleryPathsList));
            }
          }
        } else {
          isImageAttached = false;
          add(UploadImageEvent(
              imageFile: '',
              isImageAttached: isImageAttached,
              imagesList: galleryPathsList));
        }
      }
    } catch (e) {
      emit(ImagePickerError(StringConstants.kErrorPickImage));
    }
  }

  FutureOr<void> _uploadImageEvent(
      UploadImageEvent event, Emitter<PickAndUploadImageStates> emit) async {
    String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
    try {
      UploadPictureModel uploadPictureModel = await _uploadPictureRepository
          .uploadImage(File(event.imageFile), hashCode);
      if (uploadPictureModel.status == 200) {
        // emit(ImagePickerLoaded(
        //     isImageAttached: event.isImageAttached,
        //     imagePathsList: event.imagesList,
        //     imagePath: event.imageFile,
        //     uploadPictureModel: uploadPictureModel,
        //     incrementNumber: imageIndex));
      } else {
        emit(ImageNotUploaded(
            imageNotUploaded: StringConstants.kErrorImageUpload));
      }
    } catch (e) {
      emit(ImageNotUploaded(
          imageNotUploaded: StringConstants.kErrorImageUpload));
    }
  }

  _removeImage(RemoveImage event, Emitter<PickAndUploadImageStates> emit) {
    bool isImageAttached = true;
    List images = List.from(event.imagesList);
    if (event.index >= 0 && event.index < images.length) {
      images.removeAt(event.index);
      imageIndex--;
      images.isEmpty ? isImageAttached = false : isImageAttached = true;
      // emit(ImagePickerLoaded(
      //     isImageAttached: isImageAttached,
      //     imagePathsList: images,
      //     imagePath: '',
      //     uploadPictureModel: event.uploadPictureModel,
      //     incrementNumber: imageIndex));
    }
  }

  Future<void> _cropImage(
      CropImage event, Emitter<PickAndUploadImageStates> emit) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: event.imagePath,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColor.grey,
            toolbarWidgetColor: AppColor.black,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
            hideBottomControls: true),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          minimumAspectRatio: 16 / 9,
        ),
      ],
    );
    add(UploadImageEvent(
        imageFile: croppedFile!.path, isImageAttached: true, imagesList: []));
  }
}
