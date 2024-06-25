import 'dart:math';

class RandomValueGeneratorUtil {
  static generateRandomValue(String hashKey) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    String randomValue = getRandomString(16);
    String filesRandomValues = randomValue + hashKey;
    return filesRandomValues;
  }
}
