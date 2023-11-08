import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_grid_images.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';

class AssetsManageCommentsScreen extends StatelessWidget {
  static const routeName = "AssetsManageCommentsScreen";

  const AssetsManageCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsComments());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kManageComment),
      body: BlocBuilder<AssetsBloc, AssetsState>(
        builder: (context, state) {
          if (state is AssetsCommentsFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssetsCommentsFetched) {
            var data = state.fetchAssetsCommentsModel.data;
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CustomCard(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: xxxTinierSpacing, bottom: xxxTinierSpacing),
                        child: ListTile(
                          title: Row(children: [
                            Expanded(
                              child: Text(data[index].comment,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black)),
                            ),
                          ]),
                          subtitle: Column(
                            children: [
                              const SizedBox(height: tinierSpacing),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data[index].ownername,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.grey)),
                                    const SizedBox(height: tiniestSpacing),
                                    Text(data[index].created,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.grey)),
                                  ]),
                              CustomGridImages(
                                  files: data[index].files,
                                  clientId: state.clientId),
                            ],
                          ),
                        )));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: tinierSpacing);
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
