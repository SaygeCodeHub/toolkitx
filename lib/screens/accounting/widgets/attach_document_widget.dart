import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../blocs/imagePickerBloc/image_picker_state.dart';
import '../../../configs/app_spacing.dart';
import 'attach_document_section.dart';

class AttachDocumentWidget extends StatefulWidget {
  final void Function(List uploadDocList) onUploadDocument;
  final ImagePickerBloc imagePickerBloc;
  final List<dynamic> initialImages;

  const AttachDocumentWidget({
    super.key,
    required this.onUploadDocument,
    required this.imagePickerBloc,
    this.initialImages = const [],
  });

  @override
  State<AttachDocumentWidget> createState() => _AttachDocumentWidgetState();
}

class _AttachDocumentWidgetState extends State<AttachDocumentWidget> {
  late ImagePickerBloc _imagePickerBloc;

  @override
  void initState() {
    super.initState();
    _imagePickerBloc = widget.imagePickerBloc;
    _imagePickerBloc.add(FetchImages());
  }

  @override
  void dispose() {
    _imagePickerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
        bloc: _imagePickerBloc,
        buildWhen: (previousState, currentState) =>
            currentState is PickingImage ||
            currentState is ImagePicked ||
            currentState is FailedToPickImage ||
            currentState is ImagesFetched,
        builder: (context, state) {
          if (state is PickingImage) {
            return const Padding(
              padding: EdgeInsets.all(xxTinierSpacing),
              child: SizedBox(
                  width: kProgressIndicatorTogether,
                  height: kProgressIndicatorTogether,
                  child: CircularProgressIndicator()),
            );
          } else if (state is ImagePicked) {
            widget.onUploadDocument(state.pickedImagesList);
            return AttachDocumentSection(
              docMap: {
                'imageCount': state.imageCount,
                'imageList': state.pickedImagesList,
                'clientId': state.clientId,
                'fileExtension': state.fileExtension
              },
              imagePickerBloc: _imagePickerBloc,
            );
          } else if (state is FailedToPickImage) {
            return Text(
              state.errText,
              style: const TextStyle(color: AppColor.errorRed),
            );
          } else if (state is ImagesFetched) {
            widget.onUploadDocument(state.images);
            return AttachDocumentSection(
              docMap: {
                'imageCount': state.imageCount,
                'imageList': state.images,
                'clientId': state.clientId,
                'fileExtension': ''
              },
              imagePickerBloc: _imagePickerBloc,
            );
          } else {
            return AttachDocumentSection(docMap: const {
              'imageCount': 0,
              'imageList': [],
              'clientId': ''
            }, imagePickerBloc: _imagePickerBloc);
          }
        });
  }
}
