import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/colors.dart';
// import '../constants/default_constants.dart';
import '../helpers/methods.dart';
import '../services/firebase_service.dart';
import 'Constants/default_constants.dart';
import 'blocs/bloc/auth_bloc/auth_bloc.dart';
import 'blocs/theme_switch_bloc/theme_switch_bloc.dart';
import 'model/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _countryController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  final FirebaseService fb = FirebaseService();
  Country? selectedCountry;
  bool isDataHere = false;

  Map<String, bool> readOnly = {
    'Name': true,
    'Email': true,
    'Country': true,
    'Phone Number': true,
    'Password': true,
  };

  void updater(
    String label,
    TextEditingController controller,
    String oldVal,
  ) {
    if (readOnly[label]!) {
      readOnly[label] = false;
    } else {
      controller.text = oldVal;
      readOnly[label] = true;
    }
    setState(() {});
  }

  void refresher(User user) {
    // _nameController.text = nameFormater(user.name);
    _nameController.selection = TextSelection.fromPosition(
      TextPosition(offset: _nameController.text.length),
    );
    _emailController.text = user.email;
    _emailController.selection = TextSelection.fromPosition(
      TextPosition(offset: _emailController.text.length),
    );
    selectedCountry = Country.parse(user.country);
    _countryController.text =
        "${selectedCountry!.name} (+${selectedCountry!.phoneCode})";
    _phoneController.text = user.phone.toString();
    _phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: _phoneController.text.length),
    );
    _passwordController.text = user.password;
    _passwordController.selection = TextSelection.fromPosition(
      TextPosition(offset: _passwordController.text.length),
    );
    isDataHere = true;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _countryController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
    User user = context.read<AuthBloc>().state.user!;
    if (!isDataHere) {
      refresher(user);
    }

    return Scaffold(
      backgroundColor: isDark ? greyColor : secondaryWhiteColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -(MediaQuery.of(context).size.width * 1.34),
              left: -(MediaQuery.of(context).size.width * 0.5),
              child: Container(
                height: MediaQuery.of(context).size.width * 2,
                width: MediaQuery.of(context).size.width * 2,
                decoration: const BoxDecoration(
                  color: blackColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width * 0.5) - 40,
              top: (MediaQuery.of(context).size.width * 0.54),
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: 40,
                child: Text(
                  user.name[0].toUpperCase(),
                  style: textStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    size: 34,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.16,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                      Text(
                        "My Profile",
                        style: textStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: whiteColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.84,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfilePageTextField(
                    controller: _nameController,
                    readOnly: readOnly["Name"]!,
                    hint: "Enter Name",
                    label: "Name",
                    keyboardType: TextInputType.name,
                    onChangeButton: () {
                      updater(
                        "Name",
                        _nameController,
                        user.name,
                      );
                    },
                  ),
                  ProfilePageTextField(
                    controller: _emailController,
                    readOnly: readOnly["Email"]!,
                    label: "Email",
                    hint: "Enter Email Address",
                    keyboardType: TextInputType.emailAddress,
                    onChangeButton: () {
                      updater(
                        "Email",
                        _emailController,
                        user.email.toLowerCase(),
                      );
                    },
                  ),
                  ProfilePageTextField(
                    controller: _countryController,
                    readOnly: readOnly['Country']!,
                    label: "Country",
                    hint: "Select Country",
                    keyboardType: TextInputType.none,
                    onChangeButton: () {
                      updater(
                        "Country",
                        _countryController,
                        "${Country.parse(user.country).name} (+${Country.parse(user.country).phoneCode})",
                      );
                    },
                    onTap: readOnly["Country"]!
                        ? null
                        : () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              favorite: ['PK'],
                              showSearch: true,
                              onSelect: (country) {
                                selectedCountry = country;
                                _countryController.text =
                                    "${country.name} (+${country.phoneCode})";
                              },
                              countryListTheme: CountryListThemeData(
                                borderRadius: BorderRadius.circular(22),
                                bottomSheetHeight:
                                    MediaQuery.of(context).size.height * 0.6,
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
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                  ),
                  ProfilePageTextField(
                    controller: _phoneController,
                    readOnly: readOnly["Phone Number"]!,
                    label: "Phone Number",
                    hint: "Enter Phone Number",
                    keyboardType: TextInputType.phone,
                    onChangeButton: () {
                      updater(
                        "Phone Number",
                        _phoneController,
                        user.phone.toString(),
                      );
                    },
                  ),
                  ProfilePageTextField(
                    controller: _passwordController,
                    readOnly: readOnly["Password"]!,
                    label: "Password",
                    hint: "Enter Password",
                    keyboardType: TextInputType.visiblePassword,
                    onChangeButton: () {
                      updater(
                        "Password",
                        _passwordController,
                        user.password,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed:
                          !(readOnly.values.any((element) => element == false))
                              ? null
                              : () async {
                                  final updatedUser = await fb.updateUser(
                                    user: user,
                                    name: _nameController.text,
                                    email: _emailController.text.toLowerCase(),
                                    country: selectedCountry!.name,
                                    password: _passwordController.text,
                                    phone: int.parse(_phoneController.text),
                                  );
                                  await Future.delayed(
                                      const Duration(milliseconds: 0), () {
                                    context.read<AuthBloc>().add(
                                        AuthEventUpdateUser(user: updatedUser));
                                  });
                                  for (var element in readOnly.keys) {
                                    readOnly[element] = true;
                                  }
                                  setState(() {});
                                },
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        backgroundColor: isDark ? whiteColor : blackColor,
                        disabledBackgroundColor: isDark
                            ? whiteColor.withOpacity(0.6)
                            : blackColor.withOpacity(0.7),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.4,
                          40,
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: textStyle(
                          color: !isDark ? whiteColor : blackColor,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePageTextField extends StatelessWidget {
  const ProfilePageTextField({
    super.key,
    required this.controller,
    required this.readOnly,
    required this.label,
    required this.hint,
    this.onTap,
    this.onChangeButton,
    required this.keyboardType,
    this.numberField,
  });

  final TextEditingController controller;
  final bool readOnly;
  final bool? numberField;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final void Function()? onTap;
  final void Function()? onChangeButton;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.4),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: isDark
                ? whiteColor.withOpacity(0.1)
                : blackColor.withOpacity(0.1),
            cursorColor: isDark ? whiteColor : blackColor,
            selectionHandleColor: isDark ? whiteColor : blackColor,
          ),
        ),
        child: TextField(
          controller: controller,
          readOnly: label == "Country" ? true : readOnly,
          maxLines: 1,
          obscureText: label == "Password" && readOnly,
          obscuringCharacter: "◆",
          keyboardType: TextInputType.name,
          onTap: onTap,
          decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText: hint,
            labelText: label,
            fillColor: isDark ? blackColor : whiteColor,
            filled: true,
            labelStyle: textStyle(
              color: isDark
                  ? whiteColor.withOpacity(0.8)
                  : blackColor.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              size: 14,
            ),
            hintStyle: textStyle(
              color: isDark
                  ? whiteColor.withOpacity(0.5)
                  : blackColor.withOpacity(0.5),
              fontWeight: FontWeight.w600,
              size: 14,
            ),
            suffixIcon: Tooltip(
              message: "Edit",
              child: GestureDetector(
                onTap: onChangeButton,
                child: Icon(
                  readOnly ? Icons.edit_rounded : Icons.close_rounded,
                  color: isDark ? whiteColor : blackColor,
                ),
              ),
            ),
          ),
          style: defaultTextFieldStyle(
            context,
            color: isDark ? whiteColor : blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
