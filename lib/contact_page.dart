import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'blocs/theme_switch_bloc/theme_switch_bloc.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
    return Scaffold(
      backgroundColor: (isDark) ? greyColor : secondaryWhiteColor,
      appBar: AppBar(
        title: Text(
          "Contact",
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 80),
            Text(
              "Contact Info",
              style: textStyle(
                fontWeight: FontWeight.bold,
                size: 24,
                color: isDark ? whiteColor : blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                launchUrlString("tel:+923341111958");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.phone,
                    color: redDarkColor,
                    size: 22,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "+92 334 1111958",
                    style: textStyle(
                      color: isDark ? whiteColor : blackColor,
                      fontWeight: FontWeight.w600,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                launchUrlString("info@muhasba.pk");
              },
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.envelope,
                    color: redDarkColor,
                    size: 22,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "info@muhasba.pk",
                    style: textStyle(
                      color: isDark ? whiteColor : blackColor,
                      fontWeight: FontWeight.w600,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                launchUrlString("https://www.muhasba.pk");
              },
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.link,
                    color: redDarkColor,
                    size: 22,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "www.muhasba.pk",
                    style: textStyle(
                      color: isDark ? whiteColor : blackColor,
                      fontWeight: FontWeight.w600,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/images/logo.png",
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
            // Text(
            //   "Designed & Developed By Taqwa Apps",
            //   style: textStyle(
            //     color: whiteColor,
            //     fontWeight: FontWeight.w600,
            //     size: 14,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
