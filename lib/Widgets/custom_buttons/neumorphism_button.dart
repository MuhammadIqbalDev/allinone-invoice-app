import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../../blocs/bloc_exports.dart';
import '../../blocs/theme_switch_bloc/theme_switch_bloc.dart';
import '../../constants/colors.dart';

class NeuButton extends StatefulWidget {
  const NeuButton({
    super.key,
    required this.name,
    required this.context,
  });

  final String name;
  final BuildContext context;

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
    Offset offset = pressed ? const Offset(7, 7) : const Offset(20, 20);
    double blur = pressed ? 6.666 : 40;

    return GestureDetector(
      onTap: () {
        setState(() {
          pressed = true;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.of(context).pop(widget.name == "camera" ? true : false);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xff333333) : const Color(0xffefeeee),
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xff333333), const Color(0xff333333)]
                : [
                    const Color(0xffefeeee),
                    const Color(0xffefeeee),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? const Color(0xff515151) : const Color(0xffffffff),
              offset: -offset,
              blurRadius: blur,
              // inset: pressed,
            ),
            BoxShadow(
              color: isDark ? const Color(0xff151515) : const Color(0xffd1d0d0),
              offset: offset,
              blurRadius: blur,
              // inset: pressed,
            ),
          ],
        ),
        child: Icon(
          widget.name == 'camera' ? Icons.camera_alt : Icons.image,
          color: isDark ? whiteColor : blackColor,
          size: 50,
        ),
      ),
    );
  }
}
