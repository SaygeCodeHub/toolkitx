import 'package:toolkit/data/models/notification/fetch_messages_model.dart';

abstract class NotificationRepository {
  Future<FetchMessagesModel> fetchMessages(String hashCode, String userId);
}
