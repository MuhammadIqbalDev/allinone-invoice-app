import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/colors.dart';
// import '../constants/paths.dart';
import '../helpers/methods.dart';
import '../widgets/end_buttons.dart';
import 'blocs/bloc/auth_bloc/auth_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

 

  @override

  Widget build(BuildContext context) {
      
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            SizedBox(
              width: 180,
              child: Image.asset(
               'assets/images/logo.png'
              ),
            ),
            (MediaQuery.of(context).size.height <= 600)
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.06)
                : SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Text(
              "WELCOME",
              style: textStyle(
                fontWeight: FontWeight.bold,
                size: 28,
                color: redDarkColor,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
              "Muhasba invoice is an app to generate invoices for all kinds of products. It is designed to help users manage there invoices in the best possible way.",
                textAlign: TextAlign.center,
                style: textStyle(
                  size: 14,
                  color: redDarkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            EndButtons(
              mainBtnChild: Text(
                "LOGIN",
                style: textStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
              ),
              mainBtnPress: () {
                context.read<AuthBloc>().add(AuthEventShouldLogin());
              },
              secondaryBtnChild: Text(
                "GET REGISTERED",
                style: textStyle(
                  color: redDarkColor,
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
              ),
              secondaryBtnPress: () {
                context.read<AuthBloc>().add(AuthEventShouldRegister());
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
