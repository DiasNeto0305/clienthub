import 'package:client_hub/controllers/client_controller.dart';
import 'package:client_hub/models/client.dart';
import 'package:client_hub/utils/masked_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  final Client? client;

  const FormPage({Key? key, required this.client}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  void _submitForm(ClientController clientController) async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();
    final clientId = widget.client?.id ?? '';
    final newClient = Client(
      id: clientId,
      name: _formData['name'] as String,
      phoneNumber: _formData['phoneNumber'] as String,
      addressNumber: _formData['addressNumber'] as String,
      address: _formData['address'] as String,
      city: _formData['city'] as String,
      state: _formData['state'] as String,
      country: _formData['country'] as String,
      cep: _formData['cep'] as String,
    );
    await clientController.saveClient(newClient);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ClientController clientController = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Hub'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.client?.id == null ? 'Cadastro Cliente' : 'Edição Cliente',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client?.name ?? '',
                                      maxLength: 50,
                                      decoration: const InputDecoration(
                                        labelText: 'Nome',
                                        helperText: 'Ex: Alberto Dantas',
                                        suffixIcon: Icon(
                                          Icons.person,
                                        ),
                                      ),
                                      onSaved: (name) =>
                                          _formData['name'] = name!,
                                      validator: (name) {
                                        if (name!.trim().isEmpty) {
                                          return 'Nome é um campo obrigatório';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.phoneNumber
                                          : '',
                                      inputFormatters: [phoneNumberMask],
                                      decoration: const InputDecoration(
                                        labelText: 'Telefone',
                                        helperText: 'Ex: 83 988754732',
                                        suffixIcon: Icon(Icons.phone),
                                      ),
                                      onSaved: (phoneNumber) =>
                                          _formData['phoneNumber'] =
                                              phoneNumber!,
                                      validator: (phoneNumber) {
                                        if (phoneNumber!.trim().isEmpty) {
                                          return 'Telefone é um campo obrigatório';
                                        }
                                        if (phoneNumber.length != 14) {
                                          return 'Preencha o campo telefone corretamente';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.cep
                                          : '',
                                      inputFormatters: [cepMask],
                                      decoration: const InputDecoration(
                                        labelText: 'CEP',
                                        helperText: 'Ex: 58035610',
                                        suffixIcon: Icon(
                                          Icons.map,
                                        ),
                                      ),
                                      onSaved: (cep) => _formData['cep'] = cep!,
                                      validator: (cep) {
                                        if (cep!.trim().isEmpty) {
                                          return 'Cep é um campo obrigatório';
                                        }
                                        if (cep.length != 9) {
                                          return 'Preencha o campo Cep corretamente';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.address
                                          : '',
                                      maxLength: 50,
                                      decoration: const InputDecoration(
                                        labelText: 'Endereço',
                                        helperText:
                                            'Ex: Rua Terezinha Dantas Lima',
                                        suffixIcon: Icon(
                                          Icons.map,
                                        ),
                                      ),
                                      onSaved: (address) =>
                                          _formData['address'] = address!,
                                      validator: (address) {
                                        if (address!.trim().isEmpty) {
                                          return 'Endereço é um campo obrigatório';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.addressNumber
                                          : '',
                                      maxLength: 30,
                                      decoration: const InputDecoration(
                                        labelText: 'Número',
                                        helperText: 'Ex: 75',
                                        suffixIcon: Icon(
                                          Icons.location_on,
                                        ),
                                      ),
                                      onSaved: (addressNumber) =>
                                          _formData['addressNumber'] =
                                              addressNumber!,
                                      validator: (addressNumber) {
                                        if (addressNumber!.trim().isEmpty) {
                                          return 'Número é um campo obrigatório';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.city
                                          : '',
                                      maxLength: 30,
                                      decoration: const InputDecoration(
                                        labelText: 'Cidade',
                                        helperText: 'Ex: João Pessoa',
                                        suffixIcon: Icon(
                                          Icons.location_on,
                                        ),
                                      ),
                                      onSaved: (city) =>
                                          _formData['city'] = city!,
                                      validator: (city) {
                                        if (city!.trim().isEmpty) {
                                          return 'Cidade é um campo obrigatório';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.state
                                          : '',
                                      maxLength: 30,
                                      decoration: const InputDecoration(
                                        labelText: 'Estado',
                                        helperText: 'Ex: Paraíba',
                                        suffixIcon: Icon(
                                          Icons.location_city,
                                        ),
                                      ),
                                      onSaved: (state) =>
                                          _formData['state'] = state!,
                                      validator: (state) {
                                        if (state!.trim().isEmpty) {
                                          return 'Estado é um campo obrigatório';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: widget.client != null
                                          ? widget.client!.country
                                          : '',
                                      maxLength: 30,
                                      decoration: const InputDecoration(
                                        labelText: 'País',
                                        helperText: 'Ex: Brasil',
                                        suffixIcon: Icon(
                                          Icons.location_city,
                                        ),
                                      ),
                                      onSaved: (country) =>
                                          _formData['country'] = country!,
                                      validator: (country) {
                                        if (country!.trim().isEmpty) {
                                          return 'País é um campo obrigatório';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () => _submitForm(clientController),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Salvar'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
