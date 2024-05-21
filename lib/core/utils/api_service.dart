import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://api.themoviedb.org/3/movie/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$_baseUrl$endPoint', options: Options(
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMGZlMGNiOWRkN2E0MTFmZTEyNGNjYjg3MjVhZjZjOSIsInN1YiI6IjVjNzA2ZTk4MGUwYTI2MTkzZDZhZWU2ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0JkmKamOyV7gn1murEN6upc6ROHD6bOA_LaLOdYbawg"
      }
    ));
    return response.data;
  }
}