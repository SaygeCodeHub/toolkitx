import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';

class SaveOfflineData {
  void saveData(int statusId, Map saveOfflineDataMap, BuildContext context) {
    switch (statusId) {
      case 17:
      case 18:
      case 3:
      case 2:
      case 16:
        context.read<PermitBloc>().add(SaveMarkAsPrepared(
            permitId: saveOfflineDataMap['permitid'],
            controlPerson: saveOfflineDataMap['controlpersons'],
            saveOfflineMarkAsPreparedMap: saveOfflineDataMap));
    }
  }
}
