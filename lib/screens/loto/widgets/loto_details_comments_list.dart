import 'package:flutter/material.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../widgets/custom_card.dart';

class LotoDetailsCommentsList extends StatelessWidget {
  const LotoDetailsCommentsList({
    super.key,
    required this.data,
  });

  final LotoData data;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.commentslist.isNotEmpty,
      child: ListView.separated(
        itemCount: data.commentslist.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CustomCard(
              child: ListTile(
            title: Text(data.commentslist[index].comments),
            subtitle: Text(data.commentslist[index].ownername),
            trailing: Text(data.commentslist[index].created),
          ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: xxTinierSpacing,
          );
        },
      ),
    );
  }
}
