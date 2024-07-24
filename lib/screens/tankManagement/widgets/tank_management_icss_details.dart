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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<TankManagementBloc>()
              .add(FetchTmsNominationData(nominationId: nominationId));
        },
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: leftRightMargin,
          right: leftRightMargin,
          top: xxTinierSpacing,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<TankManagementBloc, TankManagementState>(
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
                return icssDetailsTabSwitchCase(
                    context, '4', tankManagementDetails, icssData);
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
          ),
        ),
      ),
    );
  }

  Widget icssDetailsTabSwitchCase(
      context, type, tankManagementDetails, icssData) {
    switch (type) {
      case '2':
      case '3':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kTank,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tank),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kProduct,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.product),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTruckNo,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.licenseplate),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kEntryDateTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.entrydate),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kEntryWeight,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.entryweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kExitDateTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.exitdate),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kExitDateTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.exitweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTankInitialWeight,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankinitialweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTankInitialLevel,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankinitiallevel),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTankFinalWeight,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankfinalweight),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTankFinalLevel,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tankfinallevel),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kFlowMeterQuantityKGAsPerCompartment,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.quantity),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kReportingTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.reportingtime),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTHAInTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.thaintime),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTHAOutTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.thaouttime),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kTHAOperationCompleted,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.thaOpereationCompleted),
        ]);
      case '4':
      case '5':
      case '1':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kTank,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.tank),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kProduct,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.product),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kStartDateTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.startdate),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kEndDateTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(icssData.enddate),
          const SizedBox(height: xxxSmallestSpacing),
          Visibility(
              visible: icssData.sourcetankreading.length > 0,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      border: TableBorder.all(),
                      columns: const [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text(StringConstants.kTankLevel)),
                        DataColumn(label: Text(StringConstants.kTankVolume)),
                        DataColumn(
                            label: Text(StringConstants.kTankTemperature)),
                        DataColumn(label: Text(StringConstants.kTankMass)),
                      ],
                      rows: List<DataRow>.generate(
                          icssData.sourcetankreading.length * 2, (index) {
                        final tank = icssData.sourcetankreading[index ~/ 2];
                        final isOpenReading = index % 2 == 0;
                        return DataRow(
                          cells: [
                            DataCell(Text(isOpenReading ? tank.tankname : '')),
                            DataCell(Text(isOpenReading
                                ? StringConstants.kOpenReading
                                : StringConstants.kCloseReading)),
                            DataCell(Text(isOpenReading
                                ? tank.openProductlevel
                                : tank.closeProductlevel)),
                            DataCell(Text(isOpenReading
                                ? tank.openTotalobservedvolume
                                : tank.openTotalobservedvolume)),
                            DataCell(Text(isOpenReading
                                ? tank.openProducttemperature
                                : tank.closeProducttemperature)),
                            DataCell(Text(isOpenReading
                                ? tank.openMassliquid
                                : tank.closeMassliquid)),
                          ],
                        );
                      })))),
          const SizedBox(height: xxxSmallestSpacing),
          Visibility(
              visible: icssData.destinationtankreading.length > 0,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      border: TableBorder.all(),
                      columns: const [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text(StringConstants.kTankLevel)),
                        DataColumn(label: Text(StringConstants.kTankVolume)),
                        DataColumn(
                            label: Text(StringConstants.kTankTemperature)),
                        DataColumn(label: Text(StringConstants.kTankMass)),
                      ],
                      rows: List<DataRow>.generate(
                          icssData.destinationtankreading.length * 2, (index) {
                        final tank =
                            icssData.destinationtankreading[index ~/ 2];
                        final isOpenReading = index % 2 == 0;
                        return DataRow(
                          cells: [
                            DataCell(Text(isOpenReading ? tank.tankname : '')),
                            DataCell(Text(isOpenReading
                                ? StringConstants.kOpenReading
                                : StringConstants.kCloseReading)),
                            DataCell(Text(isOpenReading
                                ? tank.openProductlevel
                                : tank.closeProductlevel)),
                            DataCell(Text(isOpenReading
                                ? tank.openTotalobservedvolume
                                : tank.openTotalobservedvolume)),
                            DataCell(Text(isOpenReading
                                ? tank.openProducttemperature
                                : tank.closeProducttemperature)),
                            DataCell(Text(isOpenReading
                                ? tank.openMassliquid
                                : tank.closeMassliquid)),
                          ],
                        );
                      }))))
        ]);
      default:
        return Container();
    }
  }
}
