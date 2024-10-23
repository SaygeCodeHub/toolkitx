import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/client_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/project_dropdown.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';

class IncomingInvoiceClientProjectSection extends StatelessWidget {
  const IncomingInvoiceClientProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kClient,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        ClientDropdown(
          onClientChanged: (String client,[String? clientName]) {
            context.read<AccountingBloc>().manageIncomingInvoiceMap['client'] =
                int.tryParse(client) ?? 0;
          },
          initialValue: context
                  .read<AccountingBloc>()
                  .manageIncomingInvoiceMap['clientname'] ??
              '',
        ),
        const SizedBox(height: xxTinySpacing),
        Text('Project',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        ProjectDropdown(
          onProjectChanged: (String project) {
            context.read<AccountingBloc>().manageIncomingInvoiceMap['project'] =
                int.tryParse(project) ?? 0;
          },
          initialValue: context
                  .read<AccountingBloc>()
                  .manageIncomingInvoiceMap['projectname'] ??
              '',
        )
      ],
    );
  }
}
