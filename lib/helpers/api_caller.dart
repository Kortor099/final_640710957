import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiCaller {
  static const baseUrl =
      'https://cpsu-api-49b593d4e146.herokuapp.com/api/2_2566/final/web_types';
  static final _dio = Dio(BaseOptions(responseType: ResponseType.json));

  Future<List<dynamic>> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.get('$baseUrl/$endpoint', queryParameters: params);
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.data.toString());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on DioException  catch (e) {
      var msg = e.response?.data.toString();
      debugPrint(msg);
      throw Exception(msg);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> post(String endpoint,
      {required Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.post('$baseUrl/$endpoint', data: params);
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.data.toString());
      return response.data.toString();
    } on DioException  catch (e) {
      var msg = e.response?.data.toString();
      debugPrint(msg);
      throw Exception(msg);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
