import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_switch_event.dart';
part 'theme_switch_state.dart';

class ThemeSwitchBloc extends HydratedBloc<ThemeSwitchEvent, ThemeSwitchState> {
  ThemeSwitchBloc() : super(const ThemeSwitchInitial(isDarkTheme: false)) {
    on<ThemeSwitchOnEvent>((event, emit) {
      emit(const ThemeSwitchState(isDarkTheme: true));
    });
    on<ThemeSwitchOffEvent>((event, emit) {
      emit(const ThemeSwitchState(isDarkTheme: false));
    });
    on<ThemeRefreshEvent>((event, emit) {
      emit(ThemeSwitchState(isDarkTheme: state.isDarkTheme));
    });
  }

  @override
  ThemeSwitchState? fromJson(Map<String, dynamic> json) {
    return ThemeSwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeSwitchState state) {
    return state.toMap();
  }
}
