import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/screens/permit/widgets/permit_select_file_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../widgets/progress_bar.dart';

class PermitSelectFileScreen extends StatelessWidget {
  static const routeName = 'PermitSelectFileScreen';

  const PermitSelectFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(PickFileFromStorageInitialEvent());
    return Scaffold(
        appBar: const GenericAppBar(),
        bottomNavigationBar: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {
                  context.read<PermitBloc>().add(SaveFileData());
                },
                textValue: StringConstants.kImportFile)),
        body:
            BlocConsumer<PermitBloc, PermitStates>(listener: (context, state) {
          if (state is FileFromStorageFailedToPick) {
            showCustomSnackBar(context, state.errorMessage, '');
          }
          if (state is SavingFileData) {
            ProgressBar.show(context);
          } else if (state is FileDataSaved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, PermitListScreen.routeName,
                arguments: false);
          } else if (state is FailedToSaveFileData) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        }, builder: (context, state) {
          if (state is PickFileFromStorageInitial) {
            return const PermitSelectFileSection(filePath: '');
          } else if (state is FileFromStoragePicked) {
            return PermitSelectFileSection(filePath: state.filePath);
          } else {
            return const PermitSelectFileSection(filePath: '');
          }
        }));
  }
}
