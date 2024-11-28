
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => BuisnessBloc(Storage()),
//         ),
//         BlocProvider(
//           create: (context) => ClientBloc(Storage()),
//         ),
//         BlocProvider(
//           create: (context) => InvoiceBloc(Storage()),
//         ),
//         BlocProvider(create: ((context) => ItemsBloc(Storage()))),
//         BlocProvider(
//           create: (context) => TaxBloc(Storage()),
//         ),
//         BlocProvider(
//           create: (context) => BuisnessBloc(Storage()),
//         ),
//         BlocProvider(
//           create: (context) => CategoriesBloc(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Invoices',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//           useMaterial3: true,
//         ),
//         home: const BottomNavBar(),
//       ),
//     );
//   }
// }

// Color white = Colors.white;
// Color primaryDark = fromHex('#2b488e');
// Color primary = fromHex('#8E070E');
// //  fromHex('#4f75b6');
// Color primaryLight = fromHex("#719bd1");
// Color primaryExtraLight = fromHex('#8da0cb');
// Color black = Colors.black;
// Color greyLight = const Color.fromARGB(255, 225, 225, 225);
// Color grey = Colors.grey;

// Color fromHex(String hexString) {
//   final buffer = StringBuffer();
//   if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//   buffer.write(hexString.replaceFirst('#', ''));
//   return Color(int.parse(buffer.toString(), radix: 16));
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_app/register_page.dart';
import 'package:invoice_app/services/firebase_service.dart';
import 'package:invoice_app/welcome_page.dart';
import 'package:path_provider/path_provider.dart';

import 'Constants/colors.dart';
import 'Widgets/bottombar.dart';
import 'blocs/bloc/auth_bloc/auth_bloc.dart';
import 'blocs/bloc/buisness_bloc.dart';
import 'blocs/bloc/categories_bloc.dart';
import 'blocs/bloc/client_bloc.dart';
import 'blocs/bloc/invoice_bloc.dart';
import 'blocs/bloc/items_bloc.dart';
import 'blocs/bloc/tax_bloc.dart';
import 'blocs/theme_switch_bloc/theme_switch_bloc.dart';
import 'forgot_password.dart';
import 'helpers/methods.dart';
import 'login_page.dart';
import 'services/storage.dart';

void main() async {
  var ensureInitialized = WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });


  HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeSwitchBloc(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(FirebaseService()),
          ),
          BlocProvider(
            create: (context) => BuisnessBloc(Local_Storage()),
          ),
          BlocProvider(
            create: (context) => ClientBloc(Local_Storage()),
          ),
          BlocProvider(
            create: (context) => InvoiceBloc(Local_Storage()),
          ),
          BlocProvider(create: ((context) => ItemsBloc(Local_Storage()))),
          BlocProvider(
            create: (context) => TaxBloc(Local_Storage()),
          ),
          BlocProvider(
            create: (context) => BuisnessBloc(Local_Storage()),
          ),
          BlocProvider(
            create: (context) => CategoriesBloc(),
          ),
          // BlocProvider(
          //   create: (context) => BooksBloc(FirebaseService(), Storage()),
          // ),
          // BlocProvider(
          //   create: (context) => TasksBloc(FirebaseService(), Storage()),
        ],
        child: BlocBuilder<ThemeSwitchBloc, ThemeSwitchState>(
            builder: (context, state) {
          return MaterialApp(
            title: 'Muhasba',
            debugShowCheckedModeBanner: false,
            theme: (context.read<AuthBloc>().state.user == null)
                ? ThemeData(
                    useMaterial3: true,
                    colorScheme: const ColorScheme(
                      brightness: Brightness.light,
                      primary:  blackColor,
                      onPrimary: blackColor,
                      secondary:blackColor,
                      onSecondary: blackColor,
                      error: whiteColor,
                      onError: whiteColor,
                      background: blackColor,
                      onBackground: blackColor,
                      surface: blackColor,
                      onSurface: blackColor,
                    ),
                  )
                : !state.isDarkTheme
                    ? ThemeData(
                        useMaterial3: true,
                        colorScheme: const ColorScheme(
                          brightness: Brightness.dark,
                          primary: blackColor,
                          onPrimary: blackColor,
                          secondary: blackColor,
                          onSecondary: blackColor,
                          error: redColor,
                          onError: redColor,
                          background: whiteColor,
                          onBackground: blackColor,
                          surface: whiteColor,
                          onSurface: blackColor,
                        ),
                      )
                    : ThemeData(
                        useMaterial3: true,
                        colorScheme: const ColorScheme(
                          brightness: Brightness.light,
                          primary: blackColor,
                          onPrimary: blackColor,
                          secondary: blackColor,
                          onSecondary: blackColor,
                          error: blackColor,
                          onError: blackColor,
                          background: blackColor,
                          onBackground: blackColor,
                          surface: blackColor,
                          onSurface: blackColor,
                        ),
                      ),
            home: const PageNavigator(),
          );
        }));
  }
}

class PageNavigator extends StatelessWidget {
   const PageNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    // log("page Navigator build called");

    if (context.read<AuthBloc>().state.keepLoggedIn ?? false) {
      return const BottomNavBar();
    }
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          globalValuesRemover();
          return const BottomNavBar();
        } else if (state.currentState == AuthStates.login) {
          return const LoginPage();
        } else if (state.currentState == AuthStates.forgotPass) {
          return const ForgotPasswordPage();
        } else if (state.currentState == AuthStates.register) {
          return const Register();
        } else {
          return const WelcomePage();
        }
      },
    );
  }


}
