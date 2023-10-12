import 'package:dio/dio.dart';

class NetworkRequester {
  NetworkRequester({
    required this.dio,
  });

  final Dio dio;

  Future<dynamic> get(
    String endpoint, {
    bool isProtected = true,
    bool isFormData = false,
  }) async {
    Response response = await dio.get(
      endpoint,
      options: Options(headers: {
        'Content-Type': isFormData ? 'multipart/form-data' : 'application/json',
      }),
    );

    return response.data;
  }
}
