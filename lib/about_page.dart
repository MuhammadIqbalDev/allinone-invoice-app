import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';
import 'blocs/theme_switch_bloc/theme_switch_bloc.dart';

class AboutPage extends StatelessWidget {

  const AboutPage({super.key});

  @override
Widget build(BuildContext context) {

    bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
    return Scaffold(
      backgroundColor: (isDark) ? greyColor : secondaryWhiteColor,
      appBar: AppBar(
        title: Text(
          "About",
          style: textStyle(
            fontWeight: FontWeight.w600,
            color: !isDark ? blackColor : whiteColor,
            size: 19,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            size: 25,
          ),
          color: !isDark ? blackColor : whiteColor,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 30),
          //   child: Text(
          //     "Muhasba",
          //     style: textStyle(
          //       fontWeight: FontWeight.bold,
          //       size: 22,
          //       color: isDark ? whiteColor : blackColor,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Text(
              "Muhasba invoice is an app to generate invoices for all kinds of products. It is designed to help users manage there invoices in the best possible way.",
              style: textStyle(
                color: isDark
                    ? whiteColor.withAlpha(200)
                    : blackColor.withAlpha(180),
                fontWeight: FontWeight.w500,
                size: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
