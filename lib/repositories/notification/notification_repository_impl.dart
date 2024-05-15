import 'package:toolkit/data/models/notification/fetch_messages_model.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {

  @override
  Future<FetchMessagesModel> fetchMessages(String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getmessages?hashcode=$hashCode&userid=$userId");
    return FetchMessagesModel.fromJson(response);
  }

}
