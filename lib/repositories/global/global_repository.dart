import 'package:toolkit/data/models/global/uodate_count_model.dart';

abstract class GlobalRepository {
  Future<UpdateCountModel> updateCount(Map updateCountMap);
}
