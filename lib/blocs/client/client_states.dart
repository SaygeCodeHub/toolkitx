import '../../data/models/client/client_list_model.dart';
import '../../data/models/client/home_screen_model.dart';

abstract class ClientStates {}

class ClientInitial extends ClientStates {}

class ClientListFetching extends ClientStates {}

class ClientListFetched extends ClientStates {
  final ClientListModel clientListModel;

  ClientListFetched({required this.clientListModel});
}

class FetchClientListError extends ClientStates {}

class ClientSelected extends ClientStates {}

class HomeScreenFetching extends ClientStates {}

class HomeScreenFetched extends ClientStates {
  final HomeScreenModel homeScreenModel;
  final String image;
  final List availableModules;
  final int badgeCount;
  final int unreadMessageCount;

  HomeScreenFetched(
      {required this.homeScreenModel,
      required this.image,
      required this.availableModules,
      required this.badgeCount,
      required this.unreadMessageCount});
}

class FetchHomeScreenError extends ClientStates {}
