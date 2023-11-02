import 'package:toolkit/utils/constants/string_constants.dart';

class AssetsDepreciationUtil {
  assetsDepreciationWidget(fetchAssetsDetailsModel) {
    switch (fetchAssetsDetailsModel.data.deptype) {
      case '1':
        return StringConstants.kStraightLine;
      case '2':
        return StringConstants.kDecliningBalance;
      case '3':
        return StringConstants.kSumOfYearsDigits;
      default:
        return '';
    }
  }
}
