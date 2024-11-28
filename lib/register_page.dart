import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';
import '../services/database_exceptions.dart';
import '../widgets/custom_buttons/category_selector_button.dart';
import '../widgets/end_buttons.dart';
import '../widgets/custom_buttons/gender_selector_button.dart';
import '../widgets/header_subtitle.dart';
import '../widgets/my_widgets/my_checkbox.dart';
import '../widgets/my_widgets/my_textfield_with_label.dart';
import 'Constants/name_variables.dart';
import 'Dialogs/error_dialog.dart';
import 'blocs/bloc/auth_bloc/auth_bloc.dart';
import 'model/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedPageNumber = 0;

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _countryController;
  late final TextEditingController _phoneController;
  late final TextEditingController _dOBController;
  late final TextEditingController _passController;
  late final TextEditingController _repeatPassController;

  DateTime? _selectedDateOfBirth;
  bool keepLoggedIn = false;
  bool allowSync = false;
  bool allowPromotionalTexts = false;

  bool isTapped = false;
  bool onError = false;
  late String phoneNumberHint;

  final Map<String, dynamic> genderSelectorMap = {
    male: false,
    female: false,
  };

  final Map<String, dynamic> categorySelectorMap = {
    student: false,
    freelancer: false,
    employee: false,
    businessman: false,
    unemployed: false,
    retired: false,
  };

  @override
  void initState() {
    _nameController = TextEditingController(text: nameGlobal ?? "");
    _emailController = TextEditingController(text: emailGlobal ?? "");
    _countryController = TextEditingController(
        text: (countryGlobal != null)
            ? "${countryGlobal!.name} (+${countryGlobal!.phoneCode})"
            : "");

    phoneNumberHint = (countryGlobal != null)
        ? "eg. ${countryGlobal!.example}"
        : "Enter phone number";
    _phoneController = TextEditingController(
        text: (phoneGlobal != null) ? phoneGlobal.toString() : "");
    _dOBController = TextEditingController(
        text: (birthDateGlobal != null)
            ? DateFormat("MMM dd, y").format(birthDateGlobal!)
            : "");
    if (genderGlobal != null) {
      genderSelectorMap[genderGlobal!.name] = true;
    }
    if (categoryGlobal != null) {
      categorySelectorMap[categoryGlobal!.name] = true;
    }
    _passController = TextEditingController(text: passwordGlobal ?? "");
    _repeatPassController =
        TextEditingController(text: repeatPasswordGlobal ?? "");
    allowSync = allowSyncGlobal ?? false;
    allowPromotionalTexts = allowPromotionalTextsGlobal ?? false;
    keepLoggedIn = keepLoggedInGlobal ?? false;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _dOBController.dispose();
    _passController.dispose();
    _repeatPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.exception is UserNotFound) {
          showErrorDialog(
              context, null, "User with entered credentials not found.");
        } else if (state.exception is UserAlreadyExists) {
          showErrorDialog(context, null, "User already registered!");
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
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    ...getWidgets(pageData()[selectedPageNumber]['name']),
                    EndButtons(
                      mainBtnChild: Text(
                        (selectedPageNumber == 2)
                            ? "Let's Get Started!"
                            : "NEXT",
                        style: textStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                      ),
                      mainBtnPress: pageData()[selectedPageNumber]
                          ['onMainBtnPressed'],
                      secondaryBtnPress: pageData()[selectedPageNumber]
                          ['onSecondaryBtnPressed'],
                      mainBtnTapChild: (selectedPageNumber == 2)
                          ? LoadingAnimationWidget.dotsTriangle(
                              color: redDarkColor.withAlpha(210),
                              size: 30,
                            )
                          : null,
                      mainBtnPressed:
                          (selectedPageNumber == 2) ? isTapped : null,
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

  List<Map<String, dynamic>> pageData() => [
        {
          'name': "details",
          'onMainBtnPressed': () {
            bool anyGenderSelected = genderSelectorMap.values.any(
              (val) => val == true,
            );
            if (formKey.currentState!.validate() && anyGenderSelected) {
              setState(() {
                onError = false;
                selectedPageNumber = 1;
              });
            } else if (!anyGenderSelected) {
              setState(() {
                onError = true;
              });
            }
          },
          'onSecondaryBtnPressed': () {
            context.read<AuthBloc>().add(AuthEventLogOut());
          },
        },
        {
          'name': "category",
          'onMainBtnPressed': () {
            bool anyCategorySelected = categorySelectorMap.values.any(
              (val) => val == true,
            );
            if (anyCategorySelected) {
              setState(() {
                onError = false;
                selectedPageNumber = 2;
              });
            } else {
              setState(() {
                onError = true;
              });
            }
          },
          'onSecondaryBtnPressed': () {
            setState(() {
              selectedPageNumber = 0;
            });
          },
        },
        {
          'name': "register",
          'onMainBtnPressed': () async {
            final pass = _passController.text;
            final repeatPass = _repeatPassController.text;
            if (formKey.currentState!.validate() && pass == repeatPass) {
              final user = getEnteredUser();
              context.read<AuthBloc>().add(
                    AuthEventRegister(
                      user: user,
                      keepLoggedIn: keepLoggedIn,
                    ),
                  );
            } else if (pass != repeatPass) {
              showErrorDialog(
                context,
                "Passwords Does Not Match!",
                "Please re-enter your password. Make sure you type same password on both fields.",
              );
            } else {
              log("Something wrong!");
            }
          },
          'onSecondaryBtnPressed': () {
            setState(() {
              selectedPageNumber = 1;
            });
          },
        },
      ];

  User getEnteredUser() {
    final User user = User(
      name: _nameController.text.trim(),
      dateOfBirth: birthDateGlobal!,
      gender: genderGlobal!,
      category: categoryGlobal!,
      country: countryGlobal!.name,
      phone: int.parse(_phoneController.text),
      email: _emailController.text,
      password: _passController.text,
      allowSync: allowSync,
      allowPromotionalTexts: allowPromotionalTexts,
    );
    return user;
  }

  List<Widget> getWidgets(String pageName) {
    switch (pageName) {
      case 'details':
        return [
          const Header(
            title: "Enter details",
            subtitle: "Help us know you",
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          TextFieldWithLabel(
            label: "Name",
            hint: "Enter name",
            textInputType: TextInputType.name,
            textEditingController: _nameController,
            isPasswordField: false,
            onChanged: (value) {
              nameGlobal = value;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextFieldWithLabel(
            label: "Email",
            hint: "abc@example.com",
            textInputType: TextInputType.emailAddress,
            textEditingController: _emailController,
            isPasswordField: false,
            onChanged: (value) {
              emailGlobal = value;
            },
            optionalValidations: (value) {
              if (!EmailValidator.validate(value)) {
                return "Invalid Email";
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextFieldWithLabel(
            label: "Country",
            hint: "Select country",
            textInputType: TextInputType.none,
            textEditingController: _countryController,
            isPasswordField: false,
            readOnly: true,
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                favorite: ['PK'],
                showSearch: true,
                onSelect: (country) {
                  countryGlobal = country;
                  _countryController.text =
                      "${country.name} (+${country.phoneCode})";
                  setState(() {
                    phoneNumberHint = "eg. ${country.example}";
                  });
                },
                countryListTheme: CountryListThemeData(
                  borderRadius: BorderRadius.circular(22),
                  bottomSheetHeight: MediaQuery.of(context).size.height * 0.6,
                  backgroundColor: whiteColor,
                  textStyle: textStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  searchTextStyle: textStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  inputDecoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextFieldWithLabel(
            label: "Phone",
            hint: phoneNumberHint,
            textInputType: TextInputType.phone,
            textEditingController: _phoneController,
            isPasswordField: false,
            maxLength: 10,
            onChanged: (value) {
              try {
                phoneGlobal = int.parse(value);
              } catch (e) {
                //
              }
            },
            optionalValidations: (value) {
              if (value.length < 10) {
                return "len";
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextFieldWithLabel(
            label: "Birth Date",
            hint: "Tap here...",
            textInputType: TextInputType.datetime,
            textEditingController: _dOBController,
            isPasswordField: false,
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate =
                  // await dateSelector(context, _selectedDateOfBirth);
                  await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2040),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), // Customize the appearance of the date picker dialog
          child: child!,
        );
      },
    );

    
  
              setState(() {
                if (selectedDate != null) {
                  _selectedDateOfBirth = selectedDate;
                  birthDateGlobal = selectedDate;
                  _dOBController.text =
                      DateFormat("MMM dd, y").format(selectedDate);
                }
              });
            },
            suffixIcon: const Icon(
              Icons.calendar_month_rounded,
              color: blackColor,
            ),
            suffixErrorIcon: const Icon(
              Icons.calendar_month_rounded,
              color: redDarkColor,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: genderSelectorMap.keys.map((name) {
              return GenderSelectorWidget(
                onTap: () {
                  setState(() {
                    for (var key in genderSelectorMap.keys) {
                      if (key == name) {
                        genderSelectorMap[name] = true;
                      } else {
                        genderSelectorMap[key] = false;
                      }
                    }
                    onError = false;
                  });
                  genderGlobal = Gender.values.byName(name);
                },
                isSelected: genderSelectorMap[name],
                genderName: name,
                imgString: "assets/images/genderPics/$name.png",
                genderError: onError,
              );
            }).toList(),
          ),
          const Spacer(),
        ];
      case 'category':
        return [
          Header(
            title: onError ? "Select one*" : "Select one",
            subtitle: "Tell us who you are",
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: categorySelectorMap.keys
                  .map(
                    (name) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CategorySelectorWidget(
                        categoryName: name,
                        categoryImgPath: "assets/images/categoryPics/$name.png",
                        isSelected: categorySelectorMap[name],
                        onTap: () {
                          setState(() {
                            for (var key in categorySelectorMap.keys) {
                              if (key == name) {
                                categorySelectorMap[key] = true;
                              } else {
                                categorySelectorMap[key] = false;
                              }
                            }
                          });
                          categoryGlobal = Category.values.byName(name);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ];
      case 'register':
        return [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Header(
                title: "Final Step",
                subtitle: "Set your password\n& get started!",
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/images/logo.png'
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          TextFieldWithLabel(
            label: "Password",
            hint: "Enter your password",
            textInputType: TextInputType.visiblePassword,
            textEditingController: _passController,
            isPasswordField: true,
            labelWidth: MediaQuery.of(context).size.width * 0.3,
            onChanged: (value) {
              passwordGlobal = value;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextFieldWithLabel(
            label: "Repeat Pass",
            hint: "Enter your password again",
            textInputType: TextInputType.visiblePassword,
            textEditingController: _repeatPassController,
            isPasswordField: true,
            labelWidth: MediaQuery.of(context).size.width * 0.3,
            onChanged: (value) {
              repeatPasswordGlobal = value;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          MyCheckBox(
            label: "Keep me logged in",
            value: keepLoggedIn,
            onChanged: () {
              setState(() {
                keepLoggedIn = !keepLoggedIn;
              });
              keepLoggedInGlobal = keepLoggedIn;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          MyCheckBox(
            label: "Allow Cloud Backup",
            value: allowSync,
            addInfo: true,
            infoText: "Backup on the cloud to prevent losing data",
            onChanged: () {
              setState(() {
                allowSync = !allowSync;
              });
              allowSyncGlobal = allowSync;
            },
          ),
          MyCheckBox(
            label: "Allow Promotional Texts",
            value: allowPromotionalTexts,
            onChanged: () {
              setState(() {
                allowPromotionalTexts = !allowPromotionalTexts;
              });
              allowPromotionalTextsGlobal = allowPromotionalTexts;
            },
          ),
          const Spacer(),
        ];
      default:
        return [];
    }
  }
}
