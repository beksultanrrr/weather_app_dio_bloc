import 'dart:io';
import 'package:dio/dio.dart';

class HeadersInterceptors extends InterceptorsWrapper {
  HeadersInterceptors();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      "X-API-KEY": '6b4cbaee-210d-4440-b945-df161696627d',
    });

    return super.onRequest(options, handler);
  }
}
