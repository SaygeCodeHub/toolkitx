import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';

class SaveOfflineDataUtil {
  void saveData(String status, Map saveOfflineDataMap, BuildContext context) {
    switch (status) {
      case '3':
      case '5':
      case '7':
        context.read<PermitBloc>().add(OpenPermit(saveOfflineDataMap));
        break;
      case '10':
        context.read<PermitBloc>().add(SaveMarkAsPrepared(
            permitId: saveOfflineDataMap['permitid'],
            controlPerson: saveOfflineDataMap['controlpersons'],
            saveOfflineMarkAsPreparedMap: saveOfflineDataMap));
        break;
      case '16':
        context.read<PermitBloc>().add(OpenPermit(saveOfflineDataMap));
        break;
      case '17':
      case '18':
        context
            .read<PermitBloc>()
            .add(ClosePermit(closePermitMap: saveOfflineDataMap));
        break;
    }
  }
}
