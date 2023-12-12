import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/assets/assets_manage_document_screeen.dart';
import 'package:toolkit/screens/assets/widgets/add_assets_document_checkbox.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../widgets/custom_icon_button_row.dart';

class AddAssetsDocumentScreen extends StatelessWidget {
  static const routeName = 'AddAssetsDocumentScreen';
  static List selectedCreatedForIdList = [];
  static Map addDocumentApp = {};

  const AddAssetsDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    selectedCreatedForIdList.clear();
    context.read<AssetsBloc>().add(FetchAddAssetsDocument(pageNo: 1));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kAddDocument),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: leftRightMargin),
        child: Column(
          children: [
            CustomIconButtonRow(
                primaryOnPress: () {},
                secondaryVisible: false,
                isEnabled: true,
                secondaryOnPress: () {},
                clearOnPress: () {}),
            Expanded(
              child: BlocBuilder<AssetsBloc, AssetsState>(
                buildWhen: (previousState, currentState) =>
                    currentState is AddAssetsDocumentFetching ||
                    currentState is AddAssetsDocumentFetched ||
                    currentState is AddAssetsDocumentNotFetched,
                builder: (context, state) {
                  if (state is AddAssetsDocumentFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AddAssetsDocumentFetched) {
                    var data = state.fetchAddAssetsDocumentModel.data;
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AddAssetsDocumentCheckbox(
                            data: data[index],
                            selectedCreatedForIdList: selectedCreatedForIdList,
                            onCreatedForChanged: (List id) {
                              selectedCreatedForIdList = id;
                              addDocumentApp['documents'] =
                                  selectedCreatedForIdList
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", "")
                                      .replaceAll(", ", ",");
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxxTinySpacing),
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: DatabaseUtil.getText('buttonBack'))),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
                child: BlocListener<AssetsBloc, AssetsState>(
                    listener: (context, state) {
                      if (state is ManageDocumentAdding) {
                        ProgressBar.show(context);
                      } else if (state is ManageDocumentAdded) {
                        ProgressBar.dismiss(context);
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, AssetsManageDocumentScreen.routeName);
                      } else if (state is ManageDocumentNotAdded) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(context, state.errorMessage, '');
                      }
                    },
                    child: PrimaryButton(
                        onPressed: () {
                          context.read<AssetsBloc>().add(AddManageDocument(
                              addDocumentMap: addDocumentApp));
                        },
                        textValue: StringConstants.kDone)))
          ],
        ),
      ),
    );
  }
}
