import 'package:bloc/bloc.dart';

import '../../model/businessInfo.dart';
import '../../services/storage.dart';

part 'buisness_event.dart';
part 'buisness_state.dart';

class BuisnessBloc extends Bloc<BuisnessEvent, BuisnessState> {
  BuisnessBloc(Local_Storage stb) : super(BuisnessState(businessList: [], sb: null)) {
    on<AddBuisness>((event, emit) async {
      List<Business_Info> allBuisness = [...state.businessList];
      allBuisness.add(event.buisness);

      emit(BuisnessState(businessList: allBuisness, sb: state.sb));
      await stb.saveBusinessDetails({'business': allBuisness});
    });

    on<AllBuisness>(
      (event, emit) {
        emit(BuisnessState(businessList: event.buisnessList, sb: state.sb));
      },
    );
    on<selectedBuisness>(
      (event, emit) {
        emit(BuisnessState(sb: event.sb, businessList: state.businessList));
      },
    );
    on<DeleteBuisness>((event, emit) async {
      List<Business_Info> allBuisness = [...state.businessList];
      allBuisness.removeAt(event.index);
      emit(BuisnessState(businessList: allBuisness, sb: state.sb));
      await stb.saveBusinessDetails({'business': allBuisness});
    });
    on<EditBusiness>((event, emit) {
      emit(BuisnessState(
          businessList: state.businessList
            ..removeWhere((element) =>
                (element.business_id == event.editBusiness.business_id))
            ..add(event.editBusiness),
          sb: state.sb));
    });
  }
}
