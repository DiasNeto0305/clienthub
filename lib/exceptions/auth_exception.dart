class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail já cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER : Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.': 'Acesso bloqueado. Tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_PASSWORD': 'Senha incorreta',
    'USER_DISABLED': 'Usuário desabilitado'
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autentificação';
  }
}
