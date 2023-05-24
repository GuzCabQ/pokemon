import 'package:dio/dio.dart';

import '../../domain/exceptions/exceptions.dart';

class NetworkService {
  final Dio _dio = Dio();

  NetworkService();

  Future<Response> _safeRequest(Future<Response> Function() requestFunc) async {
    try {
      var response = await requestFunc();

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ServerFailure();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.unknown) {
        throw NetworkFailure();
      } else {
        throw UnknownFailure();
      }
    } catch (e) {
      throw UnknownFailure();
    }
  }

  Future<Response> getData(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return _safeRequest(() => _dio.get(url, queryParameters: queryParameters));
  }

  Future<Response> postData(String url, {Map<String, dynamic>? data}) async {
    return _safeRequest(() => _dio.post(url, data: data));
  }
}
