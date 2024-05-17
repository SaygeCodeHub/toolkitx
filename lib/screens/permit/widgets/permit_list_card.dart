import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/connectivity_util.dart';
import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/all_permits_model.dart';
import '../../../widgets/custom_card.dart';
import '../permit_details_screen.dart';
import '../permit_list_screen.dart';
import 'permit_list_tile_title.dart';
import 'permit_list_time_subtitle.dart';

class PermitListCard extends StatelessWidget {
  final AllPermitDatum allPermitDatum;

  const PermitListCard({super.key, required this.allPermitDatum});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Padding(
            padding: const EdgeInsets.only(top: tinierSpacing),
            child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, PermitDetailsScreen.routeName,
                          arguments: allPermitDatum.id)
                      .whenComplete(() {
                    if (ConnectivityUtil.isConnected) {
                      PermitListScreen.page = 1;
                      context.read<PermitBloc>().permitListData = [];
                      context
                          .read<PermitBloc>()
                          .add(const GetAllPermits(isFromHome: false, page: 1));
                    }
                  });
                },
                title: PermitListTileTitle(allPermitDatum: allPermitDatum),
                subtitle:
                    PermitListTimeSubtitle(allPermitDatum: allPermitDatum))));
  }
}
