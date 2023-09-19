import '../configs/app_color.dart';
import '../data/models/status_tag_model.dart';
import 'database_utils.dart';

class WorkOrderTabTwoStatusUtil {
  workOrderStatusTag(certificateCode) {
    switch (certificateCode) {
      case '0':
        return StatusTagModel(
            title: DatabaseUtil.getText('Expired'), bgColor: AppColor.errorRed);
      case '1':
        return StatusTagModel(
            title: DatabaseUtil.getText('Valid'), bgColor: AppColor.orange);
      case '2':
        return StatusTagModel(
            title: DatabaseUtil.getText('Valid'), bgColor: AppColor.green);
    }
  }
}
