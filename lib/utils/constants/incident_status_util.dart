import '../database_utils.dart';

class IncidentStatusUtil {
  incidentStatusWidget(incidentDetailsModel) {
    switch (incidentDetailsModel.data!.nextStatus) {
      case '0':
        return DatabaseUtil.getText('Report');
      case '1':
        return DatabaseUtil.getText('Acknowledge');
      case '2':
        return DatabaseUtil.getText('DefineMitigation');
      case '3':
        return DatabaseUtil.getText('ApproveMitigation');
      case '4':
        return DatabaseUtil.getText('ImplementMitigation');
      default:
        return DatabaseUtil.getText('Created');
    }
  }
}
