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
  bool isInitial = true;

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
    isInitial = true;
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
        bool isAttached = false;
        List cameraPathsList =
            List.from((isInitial == false) ? event.cameraImageList : []);
        String imagePath = '';
        final pickedFile = await _imagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        isInitial = false;
        emit(PickImageLoading());
        if (pickedFile != null) {
          isAttached = true;
          cameraPathsList.add(pickedFile.path);
          for (int i = 0; i < cameraPathsList.length; i++) {
            imagePath = cameraPathsList[i];
          }
          if (isAttached == true) {
            if (event.isSignature == true) {
              add(CropImage(imagePath: imagePath));
            } else {
              add(UploadImageEvent(
                  imageFile: imagePath,
                  isImageAttached: isAttached,
                  imagesList: cameraPathsList));
            }
          }
        } else {
          isAttached = false;
          add(UploadImageEvent(
              imageFile: '',
              isImageAttached: isAttached,
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
        bool isAttached = false;
        List galleryPathsList =
            List.from((isInitial == false) ? event.galleryImagesList : []);
        String imagePath = '';
        final pickedFile =
            await _imagePicker.pickImage(source: ImageSource.gallery);
        isInitial = false;
        emit(PickImageLoading());
        if (pickedFile != null) {
          isAttached = true;
          galleryPathsList.add(pickedFile.path);
          for (int i = 0; i < galleryPathsList.length; i++) {
            imagePath = galleryPathsList[i];
          }
          if (isAttached == true) {
            if (event.isSignature == true) {
              add(CropImage(imagePath: imagePath));
            } else {
              add(UploadImageEvent(
                  imageFile: imagePath,
                  isImageAttached: isAttached,
                  imagesList: galleryPathsList));
            }
          }
        } else {
          isAttached = false;
          add(UploadImageEvent(
              imageFile: '',
              isImageAttached: isAttached,
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
        emit(ImagePickerLoaded(
            isImageAttached: event.isImageAttached,
            imagePathsList: event.imagesList,
            imagePath: event.imageFile,
            uploadPictureModel: uploadPictureModel));
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
    bool isAttached = true;
    List images = List.from(event.imagesList);
    if (event.index >= 0 && event.index < images.length) {
      images.removeAt(event.index);
      images.isEmpty ? isAttached = false : isAttached = true;
      emit(ImagePickerLoaded(
          isImageAttached: isAttached,
          imagePathsList: images,
          imagePath: '',
          uploadPictureModel: event.uploadPictureModel));
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
