import 'package:dio/dio.dart';
import 'package:doctor_booking_app/config/network/pretty_dio_logger_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @singleton
  Dio dio(PrettyDioLoggerInterceptor loggerInterceptor){
    final dio=Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      )
    );
    if (kDebugMode) {
      dio.interceptors.add(loggerInterceptor);
    }
    return dio;
  }
}