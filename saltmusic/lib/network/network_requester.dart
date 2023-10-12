import 'dart:io';

import 'package:dio/dio.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

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
