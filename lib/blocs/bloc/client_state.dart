// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'client_bloc.dart';

class ClientState {
  final List<ClientModel> clientList;
  final ClientModel? Sc;
  ClientState({
    required this.clientList,
    required this.Sc,
  });
}
