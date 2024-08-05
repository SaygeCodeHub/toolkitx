import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/widgets/secondary_button.dart';

class PermitSelectFileSection extends StatelessWidget {
  final String filePath;

  const PermitSelectFileSection({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (filePath.isNotEmpty)
                  ? Image.asset('assets/images/text.png',
                      height: 120, width: 120)
                  : Container(
                      height: 120,
                      width: 120,
                      decoration:
                          const BoxDecoration(color: AppColor.lightGrey),
                      child: const Icon(Icons.file_copy)),
              const SizedBox(height: xxTinierSpacing),
              Center(
                  child: SizedBox(
                      width: 120,
                      child: SecondaryButton(
                          onPressed: () {
                            context
                                .read<PermitBloc>()
                                .add(PickFileFromStorage());
                          },
                          textValue: 'Pick File')))
            ]));
  }
}
