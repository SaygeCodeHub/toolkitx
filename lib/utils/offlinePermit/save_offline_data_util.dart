import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';

class SaveOfflineDataUtil {
  void saveData(String status, Map saveOfflineDataMap, BuildContext context) {
    switch (status) {
      case 'ClearPermitScreen':
      case 'AcceptPermitRequestScreen':
      case 'OpenPermitScreen':
        context.read<PermitBloc>().add(OpenPermit(saveOfflineDataMap));
        break;
      case 'PreparePermitScreen':
        context.read<PermitBloc>().add(SaveMarkAsPrepared(
            permitId: saveOfflineDataMap['permitid'],
            controlPerson: saveOfflineDataMap['controlpersons'],
            saveOfflineMarkAsPreparedMap: saveOfflineDataMap));
        break;
      case 'ClosePermitScreen':
        context
            .read<PermitBloc>()
            .add(ClosePermit(closePermitMap: saveOfflineDataMap));
        break;
    }
  }
}
