import 'package:dio/dio.dart';

abstract class DioService {
  Dio dioFirebase();

  Dio dioAuth();
}