import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:news_app/news_api/news_api.dart';

void main() {
  late DioHttpService dioHttpService;
  late DioAdapter dioAdapter;

  setUp(() {
    dioAdapter = DioAdapter(
      dio: Dio(
        BaseOptions(
          baseUrl: 'https://api.test/',
          validateStatus: (status) => true,
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json',
          },
        ),
      ),
    );

    dioHttpService = DioHttpService(
      dioOverride: dioAdapter.dio,
    );
  });

  group('DioHttpService Tests', () {
    test('Successful Get Request', () async {
      dioAdapter.onGet(
        'successful-get-request-test',
        (server) => server.reply(
          200,
          {'data': 'Success!'},
        ),
      );

      final response = await dioHttpService.get(
        'successful-get-request-test',
      );

      expect(response, {'data': 'Success!'});
    });

    test('Throws custom HttpException', () async {
      dioAdapter.onGet(
        'error-test',
        (server) => server.reply(
          404,
          {'error': '404 Error!'},
        ),
      );

      expectLater(
        dioHttpService.get('error-test'),
        throwsA(isA<HttpException>()),
      );
    });
  });
}
