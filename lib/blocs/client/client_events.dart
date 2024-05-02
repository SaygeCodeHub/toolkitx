abstract class ClientEvents {}

class FetchClientList extends ClientEvents {}

class SelectClient extends ClientEvents {
  final String hashKey;
  final String apiKey;
  final String image;

  SelectClient(
      {required this.hashKey, required this.apiKey, required this.image});
}

class FetchHomeScreenData extends ClientEvents {}

class FetchChatMessages extends ClientEvents {}
