
import 'package:client_hub/exceptions/auth_exception.dart';
import 'package:client_hub/repositories/auth_repository.dart';
import 'package:client_hub/services/dio_service.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImp extends AuthRepository {
  static const _url = 'AIzaSyCG2VtiXl4YbY62z2klRvcMKw29hTscnRk';

  final DioService _dioService;

  AuthRepositoryImp(this._dioService);

  String? _token;
  String? _email;
  String? _userId;

  @override
  bool get isAuth {
    return _token != null;
  }

  @override
  String? get token {
    return isAuth ? _token : null;
  }

  @override
  String? get email {
    return isAuth ? _email : null;
  }

  @override
  String? get userId {
    return isAuth ? _userId : null;
  }

  @override
  Future<void> signin(String email, String password) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      response = await _dioService
          .dioAuth()
          .post('signInWithPassword?key=$_url', data: {
        'email': email,
        'password': password,
        'returnSecureToken': true
      });
    } on DioError catch (e) {
      if (e.response != null) {
        throw AuthException(e.response!.data['error']['message']);
      } else {
        print(e.message);
      }
    }
    _token = response.data['idToken'];
    _email = response.data['email'];
    _userId = response.data['localId'];
  }

  @override
  Future<void> signup(String email, String password) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      response = await _dioService.dioAuth().post('signUp?key=$_url', data: {
        'email': email,
        'password': password,
        'returnSecureToken': true
      });
    } on DioError catch (e) {
      if (e.response != null) {
        throw AuthException(e.response!.data['error']['message']);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }

    _token = response.data['idToken'];
    _email = response.data['email'];
    _userId = response.data['localId'];
  }

  @override
  void logout() {
    _token = null;
    _email = null;
    _userId = null;
  }
}
