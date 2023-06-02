import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/screens/permit/widgets/date_time.dart';
import 'package:toolkit/screens/permit/widgets/tags.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';

class PermitListScreen extends StatelessWidget {
  static const routeName = 'PermitListScreen';

  const PermitListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.box.get('PermitToWork')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomIconButtonRow(
              primaryOnPress: () {},
              secondaryOnPress: () {},
              clearOnPress: () {}),
          const SizedBox(height: xxTinierSpacing),
          Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        child: Padding(
                            padding: const EdgeInsets.only(top: tinier),
                            child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PermitDetailsScreen.routeName);
                                },
                                title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('WP - 00197 (!)'),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.050,
                                          decoration: BoxDecoration(
                                              color: AppColor.deepBlue,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kCardRadius)),
                                          alignment: Alignment.center,
                                          child: const Text('REQUESTED',
                                              style: TextStyle(
                                                  color: AppColor.white),
                                              textAlign: TextAlign.center))
                                    ]),
                                subtitle: Padding(
                                    padding: const EdgeInsets.only(top: tinier),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Text(
                                              'This is just a dummy permit This is just a dummy permit ',
                                              maxLines: 2),
                                          SizedBox(height: tinier),
                                          Text('Andrew oil field'),
                                          SizedBox(height: tinier),
                                          Text(
                                              'George M Mueller - Pandora-ICT GmbH'),
                                          SizedBox(height: tinier),
                                          DateTimeRow(),
                                          SizedBox(height: tinier),
                                          Tags()
                                        ])))));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinySpacing);
                  })),
          const SizedBox(height: xxTinySpacing)
        ]),
      ),
    );
  }
}
