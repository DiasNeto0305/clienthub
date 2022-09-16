abstract class AuthRepository {
  Future<void> signup(String email, String password);

  Future<void> signin(String email, String password);

  void logout();

  bool get isAuth;

  String? get token;

  String? get email;

  String? get userId;
}
