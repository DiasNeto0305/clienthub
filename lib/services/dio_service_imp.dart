import 'package:dio/dio.dart';

import 'dio_service.dart';

class DioServiceImp implements DioService {
  @override
  Dio dioFirebase() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://client-hub-3fb68-default-rtdb.firebaseio.com/',
        headers: {
          'content-type': 'application/json;charset=utf-8',
        },
      ),
    );
  }

  @override
  Dio dioAuth() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://identitytoolkit.googleapis.com/v1/accounts:',
      )
    );
  }
}
