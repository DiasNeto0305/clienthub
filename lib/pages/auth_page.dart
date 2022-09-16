import 'package:client_hub/controllers/auth_controller.dart';
import 'package:client_hub/exceptions/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'email': '',
    'password': ''
  };
  bool isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    final AuthController auth = Provider.of(context, listen: false);

    try {
      await auth.login(_authData['email'] as String,
          _authData['password'] as String, isLogin);
    } on AuthException catch (error) {
      _showErrorSnackbar(error.toString());
    } catch (error) {
      _showErrorSnackbar('Ocorreu um erro inesperado');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[900],
        content: Text(
          msg,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'Fechar',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Align(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Client Hub',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                                validator: (_email) {
                                  final email = _email ?? '';
                                  if (email.trim().isEmpty ||
                                      !email.contains('@')) {
                                    return 'Informe um email válido';
                                  }
                                  return null;
                                },
                                onSaved: (email) =>
                                    _authData['email'] = email ?? '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                ),
                                validator: (_password) {
                                  final password = _password ?? '';
                                  if (password.trim().isEmpty ||
                                      password.length < 5) {
                                    return 'Informe uma senha válida. Mínimo 5 caracteres';
                                  }
                                  return null;
                                },
                                onSaved: (password) =>
                                    _authData['password'] = password ?? '',
                              ),
                            ),
                            if (!isLogin)
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Confirmar Senha',
                                  ),
                                  validator: (_password) {
                                    final password = _password ?? '';
                                    if (_passwordController.text != password) {
                                      return 'Senhas informadas não conferem';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            if (_isLoading)
                              const CircularProgressIndicator()
                            else
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.login),
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        isLogin ? 'Entrar' : 'Registrar',
                                      ),
                                    ),
                                    onPressed: _submit,
                                  ),
                                ),
                              ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin
                                    ? 'Deseja registrar?'
                                    : 'Já possui cadastro?',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
