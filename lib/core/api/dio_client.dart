import 'package:dio/dio.dart';
import 'api_exceptions.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.github.com/',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Accept': 'application/vnd.github+json',
              'User-Agent': 'flutter-portfolio-app',
            },
            responseType: ResponseType.json,
          ),
        )..interceptors.add(LogInterceptor(responseBody: false, requestBody: false));

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ApiException('Unexpected error occurred: $e');
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 401:
            return ApiException('Unauthorized request.');
          case 403:
            return ApiException('API rate limit exceeded or access forbidden.');
          case 404:
            return ApiException('Resource not found.');
          case 500:
            return ApiException('Internal server error.');
          default:
            return ApiException('Received invalid status code: $statusCode');
        }
      case DioExceptionType.connectionError:
        return ApiException('No internet connection.');
      default:
        return ApiException('Something went wrong. Please try again later.');
    }
  }
}
