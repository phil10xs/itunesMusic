import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saltmusic/network/network_requester.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late NetworkRequester requester;

  setUp(() async {
    dio = MockDio();

    requester = NetworkRequester(dio: dio);
  });

  test('get request', () async {
    // arrange
    const String endpoint = '/your/endpoint';
    final Map<String, Object> responseData = {"feed": {}};

    when(() => dio.get(
          endpoint,
          options: any(named: 'options'),
        )).thenAnswer((_) async => Response<dynamic>(
          requestOptions: RequestOptions(path: endpoint, method: 'GET'),
          data: responseData,
        ));

    // Act
    final res = await requester.get(
      endpoint,
    );

    // Assert
    expect(res, responseData);
  });
}
