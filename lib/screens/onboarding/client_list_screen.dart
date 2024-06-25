import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_events.dart';
import '../../blocs/client/client_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/error_section.dart';
import '../home/widgets/online_modules.dart';
import '../root/root_screen.dart';

class ClientListScreen extends StatelessWidget {
  static const routeName = 'ClientListScreen';
  final bool isFromProfile;

  const ClientListScreen({Key? key, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ClientBloc>().add(FetchClientList());
    OnLineModules.isFirstTime = true;
    return Scaffold(
        appBar: AppBar(
            title: Text(DatabaseUtil.getText('ClientList')),
            titleTextStyle: Theme.of(context).textTheme.mediumLarge,
            automaticallyImplyLeading: isFromProfile),
        body: BlocConsumer<ClientBloc, ClientStates>(
            buildWhen: (previousState, currentState) =>
                currentState is ClientListFetching ||
                currentState is ClientListFetched ||
                currentState is FetchClientListError,
            listener: (context, state) {
              if (state is ClientListFetched) {
                if (state.clientListModel.data!.length == 1) {
                  Navigator.pushNamed(context, RootScreen.routeName,
                      arguments: true);
                }
              }
              if (state is ClientSelected) {
                Navigator.pushNamed(context, RootScreen.routeName,
                    arguments: true);
              }
            },
            builder: (context, state) {
              if (state is ClientListFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClientListFetched) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomPadding),
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          GridView.builder(
                              primary: false,
                              itemCount: state.clientListModel.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 1.08,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: xxTinierSpacing,
                                      mainAxisSpacing: xxTinierSpacing),
                              itemBuilder: (context, index) {
                                return CustomCard(
                                    child: InkWell(
                                        onTap: () {
                                          context.read<ClientBloc>().add(
                                              SelectClient(
                                                  hashKey: state.clientListModel
                                                      .data![index].hashkey
                                                      .toString(),
                                                  apiKey: state.clientListModel
                                                      .data![index].apikey,
                                                  image: state.clientListModel
                                                      .data![index].hashimg,
                                                  isFromProfile:
                                                      isFromProfile));
                                        },
                                        child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            imageUrl: state.clientListModel
                                                .data![index].hashimg,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                    baseColor:
                                                        AppColor.paleGrey,
                                                    highlightColor:
                                                        AppColor.white,
                                                    child: Container(
                                                        height:
                                                            kClientListShimmerHeight,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColor.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        kCardRadius)))),
                                            errorWidget: (context, url, error) =>
                                                const Icon(
                                                    Icons.error_outline_sharp,
                                                    size: kIconSize))));
                              }),
                          const SizedBox(height: topBottomPadding)
                        ])));
              } else if (state is FetchClientListError) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context.read<ClientBloc>().add(FetchClientList());
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            }));
  }
}
