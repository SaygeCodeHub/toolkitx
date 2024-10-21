import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/profile/profile_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/blood_group_enum.dart';
import '../../../utils/constants/string_constants.dart';

class BloodGroupExpansionTile extends StatelessWidget {
  final Map profileDetailsMap;

  const BloodGroupExpansionTile({super.key, required this.profileDetailsMap});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            maintainState: true,
            backgroundColor: AppColor.white,
            key: GlobalKey(),
            title: Text(
                (profileDetailsMap['bloodgrp'] == '')
                    ? StringConstants.kSelectBloodGroup
                    : profileDetailsMap['bloodgrp'],
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: BloodGroup.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: const EdgeInsets.only(
                            left: kRadioListTilePaddingLeft,
                            right: kRadioListTilePaddingRight),
                        activeColor: AppColor.deepBlue,
                        title: Text(
                            BloodGroup.values.elementAt(index).bloodGroup,
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: BloodGroup.values.elementAt(index).bloodGroup,
                        groupValue: profileDetailsMap['bloodgrp'],
                        onChanged: (value) {
                          value = BloodGroup.values.elementAt(index).bloodGroup;
                          profileDetailsMap['bloodgrp'] = value;
                          context.read<ProfileBloc>().add(
                              InitializeEditUserProfile(
                                  profileDetailsMap: profileDetailsMap));
                        });
                  })
            ]));
  }
}
