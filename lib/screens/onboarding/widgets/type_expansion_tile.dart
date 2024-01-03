import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/user_type_emun.dart';

class UserTypeExpansionTile extends StatelessWidget {
  final String typeValue;
  final String usertype;

  const UserTypeExpansionTile(
      {Key? key, required this.typeValue, required this.usertype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(ChangeUserType(
        userType: UserType.workForce.type,
        typeValue: UserType.workForce.value));
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            collapsedShape: const OutlineInputBorder(
                borderSide: BorderSide(
              color: AppColor.grey,
              width: kExpansionBorderWidth,
            )),
            collapsedBackgroundColor: AppColor.white,
            backgroundColor: AppColor.white,
            shape: const OutlineInputBorder(
                borderSide: BorderSide(
              color: AppColor.grey,
              width: kExpansionBorderWidth,
            )),
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                usertype == 'null'
                    ? UserType.workForce.type
                    : DatabaseUtil.getText(usertype),
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: UserType.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: const EdgeInsets.only(
                            left: kRadioListTilePaddingLeft,
                            right: kRadioListTilePaddingRight),
                        activeColor: AppColor.deepBlue,
                        title: Text(
                            DatabaseUtil.getText(
                                UserType.values.elementAt(index).type),
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: UserType.values.elementAt(index).type,
                        groupValue: DatabaseUtil.getText(usertype),
                        onChanged: (value) {
                          value = UserType.values.elementAt(index).type;
                          context.read<LoginBloc>().add(ChangeUserType(
                              userType: value,
                              typeValue:
                                  UserType.values.elementAt(index).value));
                        });
                  })
            ]));
  }
}
