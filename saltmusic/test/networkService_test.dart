import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saltmusic/networkService.dart';

class MockedDio extends Mock implements Dio {}

void main() {
  //initialize classes neededd to test request
  late NetworkServiceImpl mockedNSI;
  late MockedDio mockedDio;

  setUp(() {
    //instantiate classes
    mockedNSI = NetworkServiceImpl();
    mockedDio = MockedDio();
  });
  test('networkService-Mocked is successful', () async {
    Map<dynamic, dynamic> mockedData = {
      "feed": {
        "entry": [
          {
            "title": {"label": "Mocked Title"}
          }
        ]
      }
    };
    var endpoint = '/us/rss/topalbums/limit=100/json';

    when(
      () => mockedDio.get(endpoint),
    ).thenAnswer((_) async {
      return Response(
        data: json.encode(mockedData),
        statusCode: 200,
        requestOptions: RequestOptions(baseUrl: 'https://itunes.apple.com'),
      );
    });

    //testing with mocked Data? // Inject the mocked Dio into the service
    mockedNSI.dio = mockedDio;

    // act
    var r = await mockedNSI.getMusicList();

    // assert
    expect(r.data, isNotEmpty);
    expect(r.data, isNotNull);
    expect(r.statusCode, 200);
    expect(json.decode(r.data)["feed"], isMap);
  });

  test('networkService-Integration is successful', () async {
    // act
    var r = await mockedNSI.getMusicList();

    // assert
    expect(r.data, isNotEmpty);
    expect(r.data, isNotNull);
    expect(r.statusCode, 200);
    expect(json.decode(r.data)["feed"], isMap);
  });
}
