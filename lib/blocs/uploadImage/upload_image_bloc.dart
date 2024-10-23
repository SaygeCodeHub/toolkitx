import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_event.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_state.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/uploadImage/upload_image_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/uploadImage/upload_image_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final UploadImageRepository _uploadPictureRepository =
      getIt<UploadImageRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  UploadImageState get initialState => UploadImageInitial();

  UploadImageBloc() : super(UploadImageInitial()) {
    on<UploadImage>(_uploadImage);
  }

  FutureOr<void> _uploadImage(
      UploadImage event, Emitter<UploadImageState> emit) async {
    emit(UploadingImage());
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      UploadPictureModel uploadPictureModel =
          UploadPictureModel(status: 200, message: '', data: []);
      List uploadList = [];
      if (event.images.isNotEmpty) {
        for (int i = event.imageLength; i < event.images.length; i++) {
          uploadPictureModel = await _uploadPictureRepository.uploadImage(
              File(event.images[i]), hashCode);
          uploadList.addAll(uploadPictureModel.data);
        }
        if (uploadPictureModel.data.isNotEmpty) {
          emit(ImageUploaded(images: uploadList));
        } else {
          emit(ImageCouldNotUpload(
              errorMessage: StringConstants.kCannotUploadImage));
        }
      }
    } catch (e) {
      emit(ImageCouldNotUpload(errorMessage: e.toString()));
    }
  }
}
