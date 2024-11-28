import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../blocs/bloc_exports.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';
import '../services/database_exceptions.dart';
import '../widgets/my_widgets/my_textfield_with_label.dart';
import 'Dialogs/error_dialog.dart';
import 'Widgets/end_buttons.dart';
import 'Widgets/header_subtitle.dart';
import 'blocs/bloc/auth_bloc/auth_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isTapped = false;

  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.exception is UserNotFound) {
          showErrorDialog(
            context,
            null,
            "Account not found with entered email address!",
          );
        } else if (state.success ?? false) {
          showErrorDialog(
            context,
            "Success!",
            "Email with temporary password has been sent!",
          );
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
                          title: "Forgot Pass?",
                          subtitle: "We got you covered!",
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            "assets/logo.png",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: redDarkColor,
                      child: Icon(
                        Icons.email_rounded,
                        color: whiteColor,
                        size: 70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Temporary Password",
                        textAlign: TextAlign.center,
                        style: textStyle(
                          size: 18,
                          color: redDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Reset your password with ease by requesting a temporary password via email. Remember to change your password upon login as the temporary password will expire after an hour.",
                        textAlign: TextAlign.center,
                        style: textStyle(
                          size: 13,
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextFieldWithLabel(
                      label: "Email",
                      hint: "Enter your registered email",
                      textInputType: TextInputType.emailAddress,
                      labelWidth: MediaQuery.of(context).size.width * 0.3,
                      textEditingController: _emailController,
                      isPasswordField: false,
                      optionalValidations: (value) {
                        if (!EmailValidator.validate(value)) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    (MediaQuery.of(context).viewInsets.bottom == 0)
                        ? const Spacer()
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                    EndButtons(
                      mainBtnPressed: isTapped,
                      mainBtnChild: Text(
                        "GET",
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
                        final email = _emailController.text;
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthEventForgetPassword(
                                email: email,
                              ));
                        }
                      },
                      secondaryBtnPress: () {
                        context.read<AuthBloc>().add(AuthEventShouldLogin());
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
