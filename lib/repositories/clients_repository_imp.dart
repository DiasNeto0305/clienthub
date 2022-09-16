import 'package:client_hub/models/client.dart';
import 'package:client_hub/repositories/clients_repository.dart';
import 'package:client_hub/services/dio_service.dart';

class ClientsRepositoryImp extends ClientsRepository {
  final DioService _dioService;

  ClientsRepositoryImp(this._dioService);

  @override
  Future<void> addClient(Client client, String token) async {
    await _dioService.dioFirebase().post(
      'clients.json?auth=$token',
      data: {
        'name': client.name,
        'phoneNumber': client.phoneNumber,
        'cep': client.cep,
        'address': client.address,
        'addressNumber': client.addressNumber,
        'city': client.city,
        'state': client.state,
        'country': client.country
      },
    );
  }

  @override
  Future<void> updateClient(Client client, String token) async {
    await _dioService.dioFirebase().patch(
      'clients/${client.id}.json?auth=$token',
      data: {
        'name': client.name,
        'phoneNumber': client.phoneNumber,
        'cep': client.cep,
        'address': client.address,
        'addressNumber': client.addressNumber,
        'city': client.city,
        'state': client.state,
        'country': client.country
      },
    );
  }

  @override
  Future<List<Client>> getClients(String token) async {
    List<Client> clientsList = [];
    var result = await _dioService.dioFirebase().get('clients.json?auth=$token');
    result.data.forEach((clientId, clientData) {
      var client = Client(
        id: clientId,
        name: clientData['name'],
        phoneNumber: clientData['phoneNumber'],
        addressNumber: clientData['addressNumber'],
        address: clientData['address'],
        city: clientData['city'],
        state: clientData['state'],
        cep: clientData['cep'],
        country: clientData['country'],
      );
      clientsList.add(client);
    });
    return clientsList;
  }

  @override
  Future<void> removeClient(Client client, String token) async {
    await _dioService.dioFirebase().delete('clients/${client.id}.json?auth=$token');
  }
  
}
