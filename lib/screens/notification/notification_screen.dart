import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../blocs/notification/notification_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(FetchMessages());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is MessagesFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MessagesFetched) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.fetchMessagesModel.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: CustomCard(
                          child: Padding(
                              padding: const EdgeInsets.all(tiniestSpacing),
                              child: ListTile(
                                  leading: const Icon(
                                    Icons.info_rounded,
                                    color: AppColor.deepBlue,
                                    size: kMessageIconSize,
                                  ),
                                  title: Text(
                                      state.fetchMessagesModel.data![index]
                                          .notificationmessage!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black)),
                                  subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          top: xxTinierSpacing),
                                      child: Text(
                                          state.fetchMessagesModel.data![index]
                                              .processedDate!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey)))))));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTiniestSpacing);
                },
              );
            } else if (state is MessagesNotFetched) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
