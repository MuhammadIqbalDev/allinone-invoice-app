import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';
import '../services/database_exceptions.dart';
import 'Dialogs/error_dialog.dart';
import 'Widgets/end_buttons.dart';
import 'Widgets/header_subtitle.dart';
import 'Widgets/my_widgets/my_checkbox.dart';
import 'Widgets/my_widgets/my_textfield_with_label.dart';
import 'blocs/bloc/auth_bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isTapped = false;

  late final TextEditingController _emailPhoneController;
  late final TextEditingController _passwordController;
  bool keepLoggedIn = false;

  @override
  void initState() {
    _emailPhoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // log('listener called');
        if (state.exception is UserNotFound) {
          showErrorDialog(
              context, null, "Account with entered credentials not found.");
        } else if (state.exception is UserAlreadyExists) {
          showErrorDialog(context, null, "Email or phone already registered!");
        } else if (state.exception is WrongPassword) {
          showErrorDialog(context, null, "Incorrect credentials!");
        } else if (state.exception is TemporaryPasswordExpired) {
          showErrorDialog(context, null, "Temporary password is expired!");
        } else if (state.exception is GenericAuthException) {
          showErrorDialog(context, null, "Unknown error occured!");
        }
        if (state.isLoading ?? false) {
          setState(() {
            isTapped = true;
          });
        } else if (state.isLoading == false || state.isLoading == null) {
          setState(() {
            isTapped = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: (MediaQuery.of(context).viewInsets.bottom == 0)
                ? MediaQuery.of(context).size.height
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Header(
                          title: "Enter credentials",
                          subtitle: "Sign in and get going!",
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    TextFieldWithLabel(
                      label: "Email/Phone",
                      hint: "Enter email or phone",
                      textInputType: TextInputType.emailAddress,
                      labelWidth: MediaQuery.of(context).size.width * 0.32,
                      textEditingController: _emailPhoneController,
                      isPasswordField: false,
                      optionalValidations: (value) {
                        if (int.tryParse(value) == null &&
                            !EmailValidator.validate(value)) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextFieldWithLabel(
                      label: "Password",
                      hint: "Enter password",
                      textInputType: TextInputType.visiblePassword,
                      labelWidth: MediaQuery.of(context).size.width * 0.32,
                      textEditingController: _passwordController,
                      isPasswordField: true,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    MyCheckBox(
                      label: "Keep me logged in",
                      value: keepLoggedIn,
                      onChanged: () {

                        setState(() {
                          keepLoggedIn = !keepLoggedIn;
                        });
                         log("on check : keep me login $keepLoggedIn");
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(AuthEventShouldForgotPassword());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: textStyle(
                            size: 16,
                            color: redDarkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    (MediaQuery.of(context).viewInsets.bottom == 0)
                        ? const Spacer()
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                    EndButtons(
                      mainBtnPressed: isTapped,
                      mainBtnChild: Text(
                        "LOGIN",
                        style: textStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                      ),
                      mainBtnTapChild: LoadingAnimationWidget.dotsTriangle(
                        color: redDarkColor.withAlpha(210),
                        size: 30,
                      ),
                      mainBtnPress: () async {
                        final email = _emailPhoneController.text;
                        final phone = int.tryParse(_emailPhoneController.text);
                        final password = _passwordController.text;
                        if (formKey.currentState!.validate()) {
                          
                          context.read<AuthBloc>().add(AuthEventLogIn(
                                email: (phone == null) ? email : null,
                                phoneNumber: phone,
                                password: password,
                                keepLoggedIn: keepLoggedIn,
                              ));
                        }
                      },
                      secondaryBtnPress: () {
                        context.read<AuthBloc>().add(AuthEventLogOut());
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
