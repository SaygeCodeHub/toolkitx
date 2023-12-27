import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/loto_list_screen.dart';
import 'package:toolkit/screens/loto/widgets/loto_location_filter.dart';
import 'package:toolkit/screens/loto/widgets/loto_status_filter.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../blocs/loto/loto_list/loto_list_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';

class LotoFilterScreen extends StatelessWidget {
  static const routeName = 'LotoFilterScreen';

  LotoFilterScreen({super.key});

  static Map lotoFilterMap = {};
  final List location = [];
  final String selectLocationName = '';
  static bool isFromLocation = false;
  static String expenseId = '';

  @override
  Widget build(BuildContext context) {
    context.read<LotoListBloc>().add(FetchLotoMaster());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kFilter),
      body: BlocConsumer<LotoListBloc, LotoListState>(
        listener: (context, state) {
          if (state is LotoMasterFetchError) {
            Navigator.pop(context);
            showCustomSnackBar(
                context,
                DatabaseUtil.getText('some_unknown_error_please_try_again'),
                '');
          }
        },
        buildWhen: (previousState, currentState) =>
            currentState is FetchingLotoMaster ||
            currentState is LotoMasterFetched ||
            currentState is LotoMasterFetchError,
        builder: (context, state) {
          if (state is FetchingLotoMaster) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LotoMasterFetched) {
            lotoFilterMap.addAll(state.lotoMasterMap);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(StringConstants.kDateRange,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxTinySpacing),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: DatePickerTextField(
                                  editDate: lotoFilterMap["st"] ?? '',
                                  hintText: StringConstants.kSelectDate,
                                  onDateChanged: (String date) {
                                    lotoFilterMap["st"] = date;
                                  })),
                          const SizedBox(width: xxTinierSpacing),
                          const Text(StringConstants.kBis),
                          const SizedBox(width: xxTinierSpacing),
                          Expanded(
                              child: DatePickerTextField(
                                  editDate: lotoFilterMap["et"] ?? '',
                                  hintText: StringConstants.kSelectDate,
                                  onDateChanged: (String date) {
                                    lotoFilterMap["et"] = date;
                                  }))
                        ]),
                    const SizedBox(height: xxxTinySpacing),
                    LotoLocationFilter(
                      lotoFilterMap: lotoFilterMap,
                      locationList: state.fetchLotoMasterModel.data,
                    ),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Status'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    LotoStatusFilter(
                        data: state.fetchLotoMasterModel.data,
                        lotoFilterMap: lotoFilterMap),
                    const SizedBox(height: xxxSmallerSpacing),
                    PrimaryButton(
                        onPressed: () {
                          if (isFromLocation == true) {
                            context.read<LocationBloc>().add(
                                ApplyLoToListFilter(filterMap: lotoFilterMap));
                            Navigator.pop(context);
                            context
                                .read<LocationBloc>()
                                .add(FetchLocationLoTo(pageNo: 1));
                          } else {
                            context.read<LotoListBloc>().data.clear();
                            context.read<LotoListBloc>().add(
                                ApplyLotoListFilter(filterMap: lotoFilterMap));
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, LotoListScreen.routeName,
                                arguments: false);
                          }
                        },
                        textValue: DatabaseUtil.getText('Apply'))
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
