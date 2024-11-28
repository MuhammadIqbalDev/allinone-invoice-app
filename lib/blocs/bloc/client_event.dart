// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'client_bloc.dart';

class ClientEvent {
  const ClientEvent();
}

class AddClient extends ClientEvent {
  final ClientModel client;
  const AddClient({required this.client});
}

class getAllClient extends ClientEvent {
  final List<ClientModel> clientList;
  const getAllClient({required this.clientList});
}

class selectedClient extends ClientEvent {
  final ClientModel? Sc;
  selectedClient({
    required this.Sc,
  });
}

class DeleteClient extends ClientEvent {
  final int index;

  DeleteClient(this.index);
}

class EditClient extends ClientEvent {
  final ClientModel editclient;
  EditClient({
    required this.editclient,
  });
  
}
