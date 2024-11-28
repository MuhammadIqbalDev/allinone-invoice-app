import 'package:bloc/bloc.dart';
import 'package:invoice_app/services/storage.dart';

import '../../model/clientModel.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc(Local_Storage st) : super(ClientState(clientList: [], Sc: null)) {
    on<AddClient>((event, emit) async {
      List<ClientModel> clientList = [...state.clientList];
      clientList.add(event.client);

      emit(ClientState(clientList: clientList, Sc: state.Sc));
      await st.saveClientDetails({'clients': clientList});
    });
    on<getAllClient>(
      (event, emit) {
        emit(ClientState(clientList: event.clientList, Sc: state.Sc));
      },
    );
    on<selectedClient>(((event, emit) {
      emit(ClientState(clientList: state.clientList, Sc: event.Sc));
    }));
    on<DeleteClient>((event, emit) async {
      List<ClientModel> clientList = [...state.clientList];
      clientList.removeAt(event.index);

      emit(ClientState(clientList: clientList, Sc: state.Sc));
      await st.saveClientDetails({'clients': clientList});
    });
    on<EditClient>(
      (event, emit) {
        emit(ClientState(
            clientList: state.clientList
              ..removeWhere((element) =>
                  (element.client_id == event.editclient.client_id))
              ..add(event.editclient),
            Sc: state.Sc));
      },
    );

  }
}
