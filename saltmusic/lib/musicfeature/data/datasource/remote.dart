import 'package:dio/dio.dart';
import 'package:saltmusic/network/network_requester.dart';

abstract class MusicRemoteDS {
  Future<Response<Map<String, dynamic>>>? getMusicList();
}

class MusicRemoteDSImpl extends MusicRemoteDS {
  final NetworkRequester networkRequester;

  MusicRemoteDSImpl(this.networkRequester);
  @override
  Future<Response<Map<String, dynamic>>>? getMusicList() async {
    var response = await networkRequester.get(
      'https://itunes.apple.com/us/rss/topalbums/limit=100/json',
      isProtected: true,
      data: {},
      contentType: "application/json",
    );
    return response;
  }
}
