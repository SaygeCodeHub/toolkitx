import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';
import '../../../blocs/permit/permit_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../permit_list_screen.dart';
import 'permit_list_card.dart';

class PermitListTile extends StatefulWidget {
  final List permitListData;
  static bool noMoreData = false;

  const PermitListTile({Key? key, required this.permitListData})
      : super(key: key);

  @override
  State<PermitListTile> createState() => _PermitListTileState();
}

class _PermitListTileState extends State<PermitListTile> {
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;

  @override
  void initState() {
    PermitListScreen.page = 1;
    PermitListTile.noMoreData = false;
    widget.permitListData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermitBloc, PermitStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is AllPermitsFetched &&
                    PermitListTile.noMoreData != true) ||
                (currentState is FetchingAllPermits &&
                    widget.permitListData.isEmpty)),
        listener: (context, state) {
          if (state is AllPermitsFetched) {
            if (state.allPermitModel.status == 204 &&
                widget.permitListData.isNotEmpty) {
              PermitListTile.noMoreData = true;
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingAllPermits) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          }
          else if (state is AllPermitsFetched) {
            if (state.allPermitModel.data!.isNotEmpty) {
              for (var item in state.allPermitModel.data!) {
                widget.permitListData.add(item);
              }
              waitForData = false;
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      controller: controller
                        ..addListener(() {
                          if (PermitListTile.noMoreData != true &&
                              waitForData == false) {
                            if (controller.position.extentAfter < 500) {
                              PermitListScreen.page++;
                              context.read<PermitBloc>().add(GetAllPermits(
                                  page: PermitListScreen.page,
                                  isFromHome: false));
                              waitForData = true;
                            }
                          }
                        }),
                      shrinkWrap: true,
                      itemCount: widget.permitListData.length,
                      itemBuilder: (context, index) {
                        return PermitListCard(
                            allPermitDatum: widget.permitListData[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      }));
            } else {
              if (state.allPermitModel.status == 204) {
                if (state.filters.isEmpty) {
                  return const NoRecordsText(
                      text: StringConstants.kNoRecordsFilter);
                } else {
                  return NoRecordsText(
                      text: DatabaseUtil.getText('no_records_found'));
                }
              } else {
                return const SizedBox();
              }
            }
          } else {
            return const SizedBox();
          }
        });
  }
}
