// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:client_hub/models/client.dart';
import 'package:client_hub/repositories/clients_repository.dart';
import 'package:flutter/cupertino.dart';

class ClientController with ChangeNotifier {
  final String _token;
  List<Client> _items = [];
  final ClientsRepository _clientsRepository; 

  ClientController(this._token, this._items, this._clientsRepository) {
    getClients();
  }

  List<Client> get items => [..._items];

  int get itemsCount => items.length;

  Future<void> saveClient(Client client) async {
    if (client.id == '') await _clientsRepository.addClient(client, _token);
    else await _clientsRepository.updateClient(client, _token);

    getClients();
  }

  Future<void> getClients() async {
    _items = await _clientsRepository.getClients(_token);

    notifyListeners();
  }

  Future<void> removeClient(Client client) async {
    await _clientsRepository.removeClient(client, _token);

    getClients();
  }
}
