import 'package:saltmusic/network/network_requester.dart';

abstract class MusicRemoteDS {
  Future<dynamic> getMusicList();
}

class MusicRemoteDSImpl extends MusicRemoteDS {
  final NetworkRequester networkRequester;

  MusicRemoteDSImpl({required this.networkRequester});
  @override
  Future<dynamic> getMusicList() async {
    var response = await networkRequester.get(
      'https://itunes.apple.com/us/rss/topalbums/limit=100/json',
    );
    return response;
  }
}
