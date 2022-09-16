
import 'package:client_hub/models/client.dart';

abstract class ClientsRepository {
  Future<void> addClient(Client client, String token);

  Future<void> updateClient(Client client, String token);

  Future<List<Client>> getClients(String token);

  Future<void> removeClient(Client client, String token);
}