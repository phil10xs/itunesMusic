import 'package:dio/dio.dart';

class NetworkRequester {
  NetworkRequester({
    required this.dio,
  });

  final Dio dio;

  Future<Response<Map<String, dynamic>>> get(
    String endpoint, {
    Map<String, dynamic>? data,
    bool isProtected = false,
    bool isFormData = false,
    String? contentType,
  }) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: {},
        options: Options(
          method: 'GET',
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
