import 'package:dio/dio.dart';

Dio getHttpClient() {
  BaseOptions options = BaseOptions(
      baseUrl: "http://10.0.2.2:8080",
      responseType: ResponseType.plain,
      validateStatus: (code) {
        if (code == null) {
          return false;
        }
        return code >= 200;
      });

  return Dio(options);
}