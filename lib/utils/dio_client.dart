import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 75)));

  Future<dynamic> get(String requestUrl, [Map? body]) async {
    dynamic jsonResponse;
    try {
      final response = await dio.get(requestUrl, options: Options());
      jsonResponse = (response.data);
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
    return jsonResponse;
  }

  Future<dynamic> post(String requestUrl, Map? body) async {
    dynamic jsonResponse;
    try {
      final response =
          await dio.post(requestUrl, data: body, options: Options());
      jsonResponse = (response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        e.response!.statusCode;
        e.response!.data;
      } else {
        e.message.toString();
      }
    }
    return jsonResponse;
  }

  Future<dynamic> multiPart(
      String requestUrl, File imageFile, String hashCode) async {
    dynamic jsonResponse;
    try {
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'hashcode': MultipartFile.fromString(hashCode)
      });
      final response = await dio.post(requestUrl, data: formData);
      jsonResponse = jsonDecode(response.toString());
    } on DioException catch (e) {
      if (e.response != null) {
        e.response!.statusCode;
        e.response!.data;
      } else {
        e.message.toString();
      }
    }
    return jsonResponse;
  }
}
