import 'package:client_hub/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client_hub/extensions/extension_string.dart';



class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Provider.of(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Theme.of(context).primaryColor,
              child: ListTile(
                title: Text(
                  auth.email?.toFirstCharToUpperCase() ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Wrap(
                runSpacing: 8,
                children: [
                  const ListTile(
                    leading: Icon(Icons.list_outlined),
                    title: Text('Gerenciar Clientes'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Sair'),
                    onTap: () {
                      auth.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
