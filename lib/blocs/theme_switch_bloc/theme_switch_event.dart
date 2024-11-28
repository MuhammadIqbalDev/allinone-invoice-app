part of 'theme_switch_bloc.dart';

abstract class ThemeSwitchEvent {}

class ThemeSwitchOnEvent extends ThemeSwitchEvent {}

class ThemeSwitchOffEvent extends ThemeSwitchEvent {}

class ThemeRefreshEvent extends ThemeSwitchEvent {}
