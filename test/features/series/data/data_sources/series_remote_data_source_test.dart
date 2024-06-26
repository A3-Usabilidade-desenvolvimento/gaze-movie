import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client cliente;
  late SeriesRemoteDataSource remoteDataSource;

  setUp(() {
    cliente = MockClient();
    remoteDataSource = SeriesRemoteDataSourceImpl();
    registerFallbackValue(Uri());
  });

  // group('getPopularSeries', () {
  //   test(
  //     'should return [SeriesRequest] when status code is 200',
  //     () async {
  //       when(() => client.get(any())).thenAnswer(
  //         (_) async =>
  //             http.Response(jsonEncode([tSeriesRequest.toMap()]), 200),
  //       );
  //
  //       final result = await remoteDataSource.getPopularSeries();
  //
  //       expect(result, tSeriesRequest);
  //       verify(
  //         () => client.get(
  //           Uri.parse(
  //             '$kBaseUrl$kGetPopularSeriesEndpoint?api_key=$kTmdbApiKey',
  //           ),
  //         ),
  //       ).called(1);
  //       verifyNoMoreInteractions(client);
  //     },
  //   );
  // });
}
