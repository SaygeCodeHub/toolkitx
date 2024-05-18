import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';

class SaveOfflineDataUtil {
  void saveData(int statusId, Map saveOfflineDataMap, BuildContext context) {
    switch (statusId) {
      case 3:
      case 5:
      case 10:
        saveOfflineDataMap['action_key'] = 'prepare_permit';
        context.read<PermitBloc>().add(SaveMarkAsPrepared(
            permitId: saveOfflineDataMap['permitid'],
            controlPerson: saveOfflineDataMap['controlpersons'],
            saveOfflineMarkAsPreparedMap: saveOfflineDataMap));
        break;
      case 16:
      case 17:
      case 18:
    }
  }
}
