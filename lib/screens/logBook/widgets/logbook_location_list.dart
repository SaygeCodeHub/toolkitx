import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/LogBook/logbook_bloc.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class LogBookLocationList extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final String locationName;

  const LogBookLocationList(
      {Key? key, required this.data, required this.locationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: data[1].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColor.deepBlue,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(data[1][index].locname),
                            value: data[1][index].locname,
                            onChanged: (value) {
                              value = data[1][index].locname;
                              context.read<LogbookBloc>().add(
                                  SelectLogBookLocation(
                                      locationId:
                                          data[1][index].locid.toString(),
                                      locationName: value));
                              Navigator.pop(context);
                            },
                            groupValue: locationName,
                          );
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
