import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService();

  // Método para fazer uma requisição GET
  Future<List<dynamic>> getAll(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode ?? 500;
        throw Exception(
            "Failed to perform GET request. Status code: $statusCode");
      } else {
        throw Exception("Failed to perform GET request: ${e.message}");
      }
    } catch (e) {
      throw Exception("Failed to perform GET request: $e");
    }
  }

  Future<Map<String, dynamic>> getOne(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw Exception("Failed to perform GET request: $e");
    }
  }
}
