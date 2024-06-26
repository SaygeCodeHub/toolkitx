abstract class ClientEvents {}

class FetchClientList extends ClientEvents {}

class SelectClient extends ClientEvents {
  final String hashKey;
  final String apiKey;
  final String image;
  final bool isFromProfile;

  SelectClient(
      {required this.hashKey,
      required this.apiKey,
      required this.image,
      required this.isFromProfile});
}

class FetchHomeScreenData extends ClientEvents {
  final bool isFirstTime;

  FetchHomeScreenData({required this.isFirstTime});
}

class FetchChatMessages extends ClientEvents {}
