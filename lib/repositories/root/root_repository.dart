import '../../data/models/currentLocation/current_location.dart';

abstract class RootRepository {
  Future<CurrentLocationUpdateModel> updateCurrentLocation(
      double latitude, double longitude);
}
