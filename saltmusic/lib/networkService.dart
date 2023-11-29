// ignore: file_names
import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<dynamic> getMusicList();
}

class NetworkServiceImpl extends NetworkService {
  var dio = Dio(BaseOptions(baseUrl: 'https://itunes.apple.com'));

  @override
  Future<Response<dynamic>> getMusicList() async {
    var response = await dio.get(
      '/us/rss/topalbums/limit=100/json',
    );
    return response;
  }
}
