import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/colors.dart';
import '../../blocs/theme_switch_bloc/theme_switch_bloc.dart';

class DialogCloseButton extends StatelessWidget {
  const DialogCloseButton({
    Key? key,
    required this.isTopCenter,
  }) : super(key: key);

  final bool isTopCenter;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Align(
        alignment: isTopCenter ? Alignment.topCenter : Alignment.topRight,
        child: CircleAvatar(
          radius: 18.0,
          backgroundColor: isDark ? whiteColor : greyColor,
          child: Icon(
            Icons.close,
            color: isDark ? greyColor : whiteColor,
          ),
        ),
      ),
    );
  }
}
