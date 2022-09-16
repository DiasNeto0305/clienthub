import 'package:client_hub/controllers/client_controller.dart';
import 'package:client_hub/models/client.dart';
import 'package:client_hub/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientsDataTable extends DataTableSource {
  final BuildContext context;
  final List<Client> clients;

  ClientsDataTable(this.context, this.clients);

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          SelectableText(clients[index].name),
        ),
        DataCell(
          SelectableText(clients[index].phoneNumber),
        ),
        DataCell(
          SelectableText('${clients[index].address}, ${clients[index].addressNumber}'),
        ),
        DataCell(
          SelectableText('${clients[index].city} - ${clients[index].state}, ${clients[index].country}'),
        ),
        DataCell(
          SelectableText(clients[index].cep),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.FORM,
                  arguments: {
                    'client': clients[index],
                  },
                ),
                icon: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Tem Certeza?'),
                        content: Text('Deseja remover ${clients[index].name}?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: const Text('Não'),
                          ),
                          Consumer<ClientController>(
                            builder: ((ctx, value, child) => TextButton(
                                  onPressed: () async {
                                    await value.removeClient(clients[index]);

                                    Navigator.of(ctx).pop(true);
                                  },
                                  child: const Text('Sim'),
                                )),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  size: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => clients.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
