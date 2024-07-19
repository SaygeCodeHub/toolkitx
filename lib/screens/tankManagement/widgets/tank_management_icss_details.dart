import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class TankManagementICSSDetails extends StatelessWidget {
  const TankManagementICSSDetails(
      {super.key,
      required this.fetchTankManagementDetailsModel,
      required this.nominationId});

  final FetchTankManagementDetailsModel fetchTankManagementDetailsModel;
  final String nominationId;

  @override
  Widget build(BuildContext context) {
    var tankManagementDetails = fetchTankManagementDetailsModel.data;
    context
        .read<TankManagementBloc>()
        .add(FetchTmsNominationData(nominationId: nominationId));
    return Padding(
      padding: const EdgeInsets.only(
        left: leftRightMargin,
        right: leftRightMargin,
        top: xxTinierSpacing,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                context
                    .read<TankManagementBloc>()
                    .add(FetchTmsNominationData(nominationId: nominationId));
              },
              icon: const Icon(Icons.refresh)),
        ),
        BlocBuilder<TankManagementBloc, TankManagementState>(
          builder: (context, state) {
            if (state is TmsNominationDataFetching) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                child: const CircularProgressIndicator(),
              ));
            } else if (state is TmsNominationDataFetched) {
              var icssData = state.fetchTmsNominationDataModel.data;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    icssDetailsTabSwitchCase(
                        context,
                        tankManagementDetails.type,
                        tankManagementDetails,
                        icssData),
                    const SizedBox(height: xxTinierSpacing),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(border: TableBorder.all(), columns: const [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('Tank Level (mm)')),
                        DataColumn(label: Text('Tank Volume (cbm)')),
                        DataColumn(label: Text('Tank Temperature (°C)')),
                        DataColumn(label: Text('Tank Mass (kg)')),
                      ], rows: const [
                        DataRow(cells: [
                          DataCell(Text("ACT Tank 678")),
                          DataCell(Text("Open reading")),
                          DataCell(Text("")),
                          DataCell(Text("")),
                          DataCell(Text("")),
                          DataCell(Text("")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('Close reading')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ]),
                    )
                  ],
                ),
              );
            } else if (state is TmsNominationDataNotFetched) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                child: const Text(StringConstants.kNoRecordsFound),
              ));
            }
            return const SizedBox.shrink();
          },
        )
      ]),
    );
  }

  Widget icssDetailsTabSwitchCase(
      context, type, tankManagementDetails, icssData) {
    switch (type) {
      case '1':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Tank',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Product',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.vesselname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Density (kg/m3)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.density),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Temperature (°C)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.temperature),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Truck No',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.actualdeparturedatetime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Entry DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.entrydate),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Entry Weight (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.entryweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Exit DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.exitdate),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Exit Weight (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.exitweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Initial Weight (kg) ',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankinitialweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Initial Level (mm)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankinitiallevel),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Final Weight (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankfinalweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Final Level (mm)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankfinallevel),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Flowmeter Quantity (kg) per Compartment',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Reporting Time',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.reportingtime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('THA In Time',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.thaintime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('THA Out Time',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.thaouttime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('THA Opereation Completed',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.thaOpereationCompleted),
        ]);
      case '2':
      case '3':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Tank',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('PitA - Tank-1Product',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Product 3',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(icssData.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Density (kg/m3)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.density),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Start DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.startdate),
          const SizedBox(height: xxxSmallestSpacing),
          Text('End DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.enddate),
        ]);

      default:
        return Container();
    }
  }
}
