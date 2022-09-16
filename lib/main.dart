import 'package:client_hub/controllers/auth_controller.dart';
import 'package:client_hub/controllers/client_controller.dart';
import 'package:client_hub/pages/auth_page.dart';
import 'package:client_hub/pages/form_page.dart';
import 'package:client_hub/pages/home_page.dart';
import 'package:client_hub/pages/auth_or_home.dart';
import 'package:client_hub/repositories/auth_repository_imp.dart';
import 'package:client_hub/repositories/clients_repository_imp.dart';
import 'package:client_hub/services/dio_service_imp.dart';
import 'package:client_hub/utils/app_routes.dart';
import 'package:client_hub/utils/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                AuthController(AuthRepositoryImp(DioServiceImp()))),
        ChangeNotifierProxyProvider<AuthController, ClientController>(
          create: (context) =>
              ClientController('', [], ClientsRepositoryImp(DioServiceImp())),
          update: (ctx, auth, previous) {
            return ClientController(auth.token ?? '', previous?.items ?? [],
                ClientsRepositoryImp(DioServiceImp()));
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        scrollBehavior: CustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH_OR_HOME: (context) => const AuthOrHome(),
          AppRoutes.AUTH: (context) => const AuthPage(),
          AppRoutes.HOME: (context) => const HomePage(),
          AppRoutes.FORM: (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map;

            return FormPage(client: args['client']);
          },
        },
      ),
    );
  }
}
