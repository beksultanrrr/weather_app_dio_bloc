import 'package:dio/dio.dart';

import '../../constants/api_routs.dart';
import 'headers_interceptors.dart';

enum HttpMethod { get, post, delete, patch }

const httpMethodList = [
  HttpMethod.get,
  HttpMethod.post,
  HttpMethod.delete,
  HttpMethod.patch
];
const httpMethodValues = {
  HttpMethod.get: "get",
  HttpMethod.post: "post",
  HttpMethod.delete: "delete",
  HttpMethod.patch: "patch"
};

class DioService {
  Dio? _dio;

  static final DioService _dioManager = DioService._instance();

  factory DioService() => _dioManager;

  DioService._instance() {
    if (_dio == null) {
      _init();
    }
  }

  _init() {
    BaseOptions options = BaseOptions(
      baseUrl: APIRouts
          .root, //* Тут базовый адрес до твоей API. К примеру https://risefall.org/
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(minutes: 10),
    );
    _dio = Dio(options);

    //* Добавляешь HeadersInterceptors
    _dio!.interceptors.add(HeadersInterceptors());
  }

  Future<dynamic> request(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      //& Response
      Response response = await _dio!.request(
        path,
        queryParameters: method == HttpMethod.get ? params : null,
        data: params,
        options: Options(method: httpMethodValues[method]),
      );

      return response;
    } catch (error) {
      print(error);
    }
  }
}
