import 'package:client_hub/controllers/client_controller.dart';
import 'package:client_hub/utils/app_routes.dart';
import 'package:client_hub/widgets/clients_data_table.dart';
import 'package:client_hub/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Hub'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1500),
              child: SizedBox(
                width: double.infinity,
                child: Consumer<ClientController>(
                  builder: (ctx, value, child) => PaginatedDataTable(
                    sortColumnIndex: 0,
                    header: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SelectableText(
                            'Lista de Clientes',
                            style: TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.FORM, arguments: {
                                'client': null,
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Adicionar Cliente'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    columns: const [
                      DataColumn(
                        label: SelectableText('Nome'),
                      ),
                      DataColumn(
                        label: SelectableText('Telefone'),
                      ),
                      DataColumn(
                        label: SelectableText('Endereço'),
                      ),
                      DataColumn(
                        label: SelectableText('Cidade'),
                      ),
                      DataColumn(
                        label: SelectableText('CEP'),
                      ),
                      DataColumn(
                        label: SelectableText('Ações'),
                      ),
                    ],
                    source: ClientsDataTable(context, value.items),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
