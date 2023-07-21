import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/LogBook/logbook_bloc.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../blocs/LogBook/logbook_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/encrypt_class.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../logbook_details_screen.dart';

class LogbookList extends StatefulWidget {
  static bool noMoreData = false;
  static int page = 1;
  final List logbookData;

  const LogbookList({Key? key, required this.logbookData}) : super(key: key);

  @override
  State<LogbookList> createState() => _LogbookListState();
}

class _LogbookListState extends State<LogbookList> {
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;

  @override
  void initState() {
    LogbookList.page = 1;
    LogbookList.noMoreData = false;
    widget.logbookData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocConsumer<LogbookBloc, LogbookStates>(
      buildWhen: (previousState, currentState) => ((currentState
                  is LogbookListFetched &&
              LogbookList.noMoreData != true) ||
          (currentState is FetchingLogbookList && widget.logbookData.isEmpty)),
      listener: (context, state) {
        if (state is LogbookListFetched) {
          if (state.fetchLogBookListModel.status == 204 &&
              widget.logbookData.isNotEmpty) {
            LogbookList.noMoreData = true;
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        }
      },
      builder: (context, state) {
        if (state is FetchingLogbookList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LogbookListFetched) {
          if (state.fetchLogBookListModel.data.isNotEmpty) {
            for (var item in state.fetchLogBookListModel.data) {
              widget.logbookData.add(item);
            }
            waitForData = false;
            return ListView.separated(
                controller: controller
                  ..addListener(() {
                    if (LogbookList.noMoreData != true &&
                        waitForData == false) {
                      if (controller.position.extentAfter < 500) {
                        LogbookList.page++;
                        context
                            .read<LogbookBloc>()
                            .add(FetchLogbookList(pageNo: LogbookList.page));
                        waitForData = true;
                      }
                    }
                  }),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.logbookData.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: Padding(
                      padding: const EdgeInsets.only(top: tinierSpacing),
                      child: ListTile(
                        onTap: () {
                          String encryptId = '';
                          encryptId = EncryptData.encryptAESPrivateKey(
                              state.fetchLogBookListModel.data[index].id
                                  .toString(),
                              state.privateApiKey);
                          Navigator.pushNamed(
                              context, LogBookDetailsScreen.routeName,
                              arguments: encryptId);
                        },
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Text(widget.logbookData[index].logbookname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.black)),
                              ]),
                              Text(widget.logbookData[index].status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.deepBlue))
                            ]),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: tinierSpacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.logbookData[index].description),
                              const SizedBox(height: tinierSpacing),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/calendar.png',
                                        height: kImageHeight,
                                        width: kImageWidth),
                                    const SizedBox(width: tiniestSpacing),
                                    Text(
                                        widget.logbookData[index].eventdatetime)
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tinierSpacing);
                });
          } else {
            return NoRecordsText(
                text: DatabaseUtil.getText('no_records_found'));
          }
        } else {
          return const SizedBox();
        }
      },
    ));
  }
}
