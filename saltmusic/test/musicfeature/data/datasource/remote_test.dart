import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saltmusic/musicfeature/data/datasource/remote.dart';
import 'package:saltmusic/network/network_requester.dart';

class MockNetworkRequester extends Mock implements NetworkRequester {}

void main() {
  late MockNetworkRequester requester;
  late MusicRemoteDSImpl remoteImpl;

  setUp(() {
    requester = MockNetworkRequester();
    remoteImpl = MusicRemoteDSImpl(networkRequester: requester);
  });
  test('get itunes music remote', () async {
    var url = 'https://itunes.apple.com/us/rss/topalbums/limit=100/json';

    // arrange
    Map<String, Object> res = {"feed": {}};

    when(() => requester.get(url)).thenAnswer((_) async => res);

    // act
    var r = await remoteImpl.getMusicList();

    // assert
    expect(r!['feed'], isMap);
  });
}
