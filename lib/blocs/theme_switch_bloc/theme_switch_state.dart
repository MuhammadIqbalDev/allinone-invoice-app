part of 'theme_switch_bloc.dart';

class ThemeSwitchState {
  final bool isDarkTheme;

  const ThemeSwitchState({required this.isDarkTheme});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDarkTheme': isDarkTheme,
    };
  }

  factory ThemeSwitchState.fromMap(Map<String, dynamic> map) {
    return ThemeSwitchState(
      isDarkTheme: map['isDarkTheme'] as bool,
    );
  }
}

class ThemeSwitchInitial extends ThemeSwitchState {
  const ThemeSwitchInitial({required super.isDarkTheme});
}
