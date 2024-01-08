import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/assets/assets_bloc.dart';

import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../add_assets_document_screen.dart';
import 'assets_add_document_list_body.dart';

class AddAssetsDocumentBody extends StatelessWidget {
  const AddAssetsDocumentBody({
    super.key,
    required this.pageNo,
  });

  final int pageNo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<AssetsBloc, AssetsState>(
        buildWhen: (previousState, currentState) =>
            (currentState is AddAssetsDocumentFetching &&
                AddAssetsDocumentScreen.pageNo == 1) ||
            currentState is AddAssetsDocumentFetched,
        listener: (context, state) {
          if (state is AddAssetsDocumentFetched) {
            if (state.fetchAddAssetsDocumentModel.status == 204 &&
                context.read<AssetsBloc>().addDocumentDatum.isNotEmpty) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is AddAssetsDocumentFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddAssetsDocumentFetched) {
            if (context.read<AssetsBloc>().addDocumentDatum.isNotEmpty) {
              return AssetsAddDocumentListBody(
                data: state.data,
              );
            } else if (state.fetchAddAssetsDocumentModel.status == 204 &&
                context.read<AssetsBloc>().addDocumentDatum.isEmpty) {
              if (context.read<AssetsBloc>().documentFilters.isNotEmpty) {
                return const NoRecordsText(
                    text: StringConstants.kNoRecordsFilter);
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            }
          } else if (state is AddAssetsDocumentNotFetched) {
            return NoRecordsText(
                text: DatabaseUtil.getText('no_records_found'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
