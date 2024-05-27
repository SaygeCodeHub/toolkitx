import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/searchTextField/search_text_field_bloc.dart';
import 'package:toolkit/blocs/searchTextField/search_text_field_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/widgets/assign_team_list.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../blocs/searchTextField/search_text_field_event.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button.dart';

class LotoAssignTeamScreen extends StatelessWidget {
  static const routeName = 'LotoAssignTeamScreen';

  const LotoAssignTeamScreen({super.key, required this.isRemoveOperation});

  final String isRemoveOperation;
  static String name = '';

  static int pageNo = 1;
  static bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LotoDetailsBloc>().lotoTeamReachedMax = false;
    context.read<LotoDetailsBloc>().lotoAssignTeamDatum = [];
    context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
        pageNo: pageNo, isRemove: isRemoveOperation, name: ''));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText("assign_Team")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: leftRightMargin),
        child: Column(
          children: [
            CustomSearchTextField(onChange: (value) {
              name = value;
            }, onSearch: () {
              pageNo = 1;
              context.read<LotoDetailsBloc>().lotoTeamReachedMax = false;
              context.read<LotoDetailsBloc>().lotoAssignTeamDatum = [];
              context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
                  pageNo: pageNo, isRemove: isRemoveOperation, name: name));
            }, onClear: () {
              pageNo = 1;
              context.read<LotoDetailsBloc>().lotoTeamReachedMax = false;
              context.read<LotoDetailsBloc>().lotoAssignTeamDatum = [];
              name = '';
              context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
                  pageNo: pageNo, isRemove: isRemoveOperation, name: name));
            }),
            const SizedBox(height: tinySpacing),
            AssignTeamList(isRemoveOperation: isRemoveOperation),
          ],
        ),
      ),
    );
  }
}

class CustomSearchTextField extends StatelessWidget {
  final void Function(String)? onChange;
  final void Function() onSearch;
  final void Function() onClear;

  CustomSearchTextField(
      {super.key,
      required this.onChange,
      required this.onSearch,
      required this.onClear});
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<SearchTextFieldBloc>().add(InitiateSearch());
    return TextFormField(
        controller: textController,
        onChanged: onChange,
        decoration: InputDecoration(
            suffixIcon: BlocBuilder<SearchTextFieldBloc, SearchTextFieldStates>(
                builder: (context, state) {
              if (state is SearchTextFieldInitial) {
                return CustomIconButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (textController.text != '' ||
                          textController.text.trim() != '') {
                        onSearch();
                        context.read<SearchTextFieldBloc>().add(Search());
                      }
                    },
                    icon: Icons.search);
              } else if (state is Searched) {
                return CustomIconButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      onClear();
                      textController.text = '';
                      context.read<SearchTextFieldBloc>().add(InitiateSearch());
                    },
                    icon: Icons.close);
              } else {
                return const SizedBox.shrink();
              }
            }),
            hintStyle: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey),
            hintText: StringConstants.kSearch,
            contentPadding: const EdgeInsets.all(xxxTinierSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            filled: true,
            fillColor: AppColor.white));
  }
}
