import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/accounting/fetch_bank_statements_model.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../../widgets/android_pop_up.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../manage_bank_statement_screen.dart';

class BankStatementListTitle extends StatelessWidget {
  final BankStatementsDatum bankStatement;

  const BankStatementListTitle({super.key, required this.bankStatement});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
        child: Row(
          children: [
            Expanded(
              child: Text(bankStatement.entity,
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis)),
            ),
            const Spacer(),
            CustomIconButton(
                icon: Icons.edit,
                onPressed: () {
                  context.read<AccountingBloc>().add(
                      FetchBankStatement(bankStatementId: bankStatement.id));
                  Navigator.pushNamed(
                      context, ManageBankStatementScreen.routeName,
                      arguments: true);
                },
                size: 20),
            const SizedBox(width: xxTinierSpacing),
            CustomIconButton(
                icon: Icons.delete,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AndroidPopUp(
                            titleValue:
                                'Are you sure you want to delete this statement?',
                            contentValue: '',
                            onPrimaryButton: () {
                              Navigator.pop(context);
                              context.read<AccountingBloc>().add(
                                  DeleteBankStatement(
                                      statementId: bankStatement.id));
                            });
                      });
                },
                size: 20),
            const SizedBox(width: tiniestSpacing),
            CustomIconButton(
              icon: Icons.attach_file_outlined,
              onPressed: () {
                final files = bankStatement.file.split(',');
                final firstFile= files.isNotEmpty ? files.first : '';
                if (firstFile.isNotEmpty) {
                  launchUrlString(
                      '${ApiConstants.viewDocBaseUrl}$firstFile&code=${RandomValueGeneratorUtil.generateRandomValue(context.read<AccountingBloc>().clientId)}',
                      mode: LaunchMode.externalApplication);
                }
              },
            ),
            const SizedBox(width: tiniestSpacing)
          ],
        ));
  }
}
