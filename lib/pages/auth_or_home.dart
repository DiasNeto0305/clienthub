import 'package:client_hub/controllers/auth_controller.dart';
import 'package:client_hub/pages/auth_page.dart';
import 'package:client_hub/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHome extends StatefulWidget {
  const AuthOrHome({Key? key}) : super(key: key);

  @override
  State<AuthOrHome> createState() => _AuthOrHomeState();
}

class _AuthOrHomeState extends State<AuthOrHome> {
  
  @override
  Widget build(BuildContext context) {
    AuthController auth = Provider.of(context);
    return auth.isAuth ? const HomePage() : const AuthPage();
  }
}
