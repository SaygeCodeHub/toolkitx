import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../../utils/incident_view_image_util.dart';

class ViewBankStatementFile extends StatelessWidget {
  const ViewBankStatementFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.kViewImage,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: ViewImageUtil.viewImageList(context
                    .read<AccountingBloc>()
                    .manageBankStatementMap['view_files'])
                .length,
            itemBuilder: (context, index) {
              return InkWell(
                  splashColor: AppColor.transparent,
                  highlightColor: AppColor.transparent,
                  onTap: () {
                    launchUrlString(
                        '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(context.read<AccountingBloc>().manageBankStatementMap['view_files'])[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(context.read<AccountingBloc>().clientId)}',
                        mode: LaunchMode.externalApplication);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                    child: Text(
                        '${index + 1}] ${ViewImageUtil.viewImageList(context.read<AccountingBloc>().manageBankStatementMap['view_files'])[index]}',
                        style: const TextStyle(color: AppColor.deepBlue)),
                  ));
            }),
        const SizedBox(height: xxTinySpacing)
      ],
    );
  }
}
