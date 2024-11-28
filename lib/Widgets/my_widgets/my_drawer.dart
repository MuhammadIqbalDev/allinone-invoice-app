// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../about_page.dart';
import '../../blocs/bloc/auth_bloc/auth_bloc.dart';
import '../../blocs/theme_switch_bloc/theme_switch_bloc.dart';
import '../../constants/colors.dart';
import '../../contact_page.dart';
import '../../helpers/methods.dart';
import '../../main.dart';
// import '../../models/user.dart';
// import '../../pages/about_page.dart';
// import '../../pages/applications_page.dart';
// import '../../pages/contact_page.dart';
// import '../../pages/home/cash_book/book_invites_page.dart';
// import '../../pages/home/cash_book/cashbook_home.dart';
// import '../../pages/home/task_scheduler/hidden_task_books_page.dart';
// import '../../pages/home/task_scheduler/task_home.dart';
// import '../../pages/profile_page.dart';
import '../../model/user.dart';
import '../../newClient.dart';
import '../../profile_page.dart';
import '../../services/firebase_service.dart';
import 'confirmation_dialog.dart';
// import '../../utilities/dialogs/confirmation_dialog.dart';

class MyDrawer extends StatefulWidget {
  final BuildContext existingCxt;
  final String? view;
  const MyDrawer({
    Key? key,
    required this.existingCxt,
    this.view,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

final TextEditingController _currency = TextEditingController();

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    User user = context.read<AuthBloc>().state.user!;
    ThemeSwitchBloc themeBloc = context.read<ThemeSwitchBloc>();
    // BooksBloc booksBloc = context.read<BooksBloc>();

    return BlocBuilder<ThemeSwitchBloc, ThemeSwitchState>(
      builder: (context, state) {
        bool isDark = state.isDarkTheme;
        return Drawer(
          backgroundColor: isDark ? blackColor : whiteColor,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  left: -200,
                  top: -190,
                  child: Container(
                    padding: const EdgeInsets.all(60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? whiteColor.withAlpha(8)
                          : blackColor.withAlpha(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(60),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? whiteColor.withAlpha(10)
                            : blackColor.withAlpha(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? whiteColor.withAlpha(8)
                              : blackColor.withAlpha(14),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: isDark ? blackColor : whiteColor,
                            radius: 40,
                            child: Text(
                              user.name[0].toUpperCase(),
                              style: textStyle(
                                color: isDark ? whiteColor : blackColor,
                                fontWeight: FontWeight.bold,
                                size: 34,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 110,
                  top: 45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: Text(
                            nameFormater(user.name),
                            softWrap: true,
                            style: textStyle(
                              color: isDark ? whiteColor : blackColor,
                              fontWeight: FontWeight.bold,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: Text(
                            user.email,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(
                              color: isDark ? whiteColor : blackColor,
                              fontWeight: FontWeight.w600,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Buttons List
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        // Home
                        // ListTile(
                        //   onTap: viewProvider(
                        //     view: widget.view,
                        //     forBook: () {
                        //       Navigator.of(context)
                        //           .pushReplacement(MaterialPageRoute(
                        //         builder: (context) => const CashBookHome(),
                        //       ));
                        //     },
                        //     forTask: () {
                        //       Navigator.of(context)
                        //           .pushReplacement(MaterialPageRoute(
                        //         builder: (context) => const TaskHome(),
                        //       ));
                        //     },
                        //   ) as void Function(),
                        // leading: Icon(
                        //   Icons.home_outlined,
                        //   color: isDark ? whiteColor : blackColor,
                        // ),
                        // title: Text(
                        //   "Home",
                        //   style: textStyle(
                        //     color: isDark ? whiteColor : blackColor,
                        //     fontWeight: FontWeight.w600,
                        //     size: 16,
                        //   ),
                        // ),
                        // ),
                        // Invites
                        // if (widget.view == 'book')
                        //   ListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const BookInvitesPage(),
                        //           ));
                        //     },
                        //     leading: Icon(
                        //       Icons.library_books_outlined,
                        //       color: isDark ? whiteColor : blackColor,
                        //     ),
                        //     title: Text(
                        //       "Invitations",
                        //       style: textStyle(
                        //         color: isDark ? whiteColor : blackColor,
                        //         fontWeight: FontWeight.w600,
                        //         size: 16,
                        //       ),
                        //     ),
                        //     trailing: StreamBuilder<int>(
                        //         stream: firebaseService.getInvitationsLength(
                        //           userPhone: user.phone,
                        //         ),
                        //         builder: (context, snapshot) {
                        //           if (!snapshot.hasData ||
                        //               snapshot.data == 0) {
                        //             return const SizedBox();
                        //           }
                        //           return Container(
                        //             padding: const EdgeInsets.symmetric(
                        //               horizontal: 5,
                        //               vertical: 3,
                        //             ),
                        //             decoration: BoxDecoration(
                        //               color: isDark ? whiteColor : blackColor,
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: Text(
                        //               snapshot.data.toString(),
                        //               style: textStyle(
                        //                 size: 12,
                        //                 color:
                        //                     isDark ? blackColor : whiteColor,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           );
                        //         }),
                        //   ),
                        // Hidden Task Books
                        // if (widget.view == 'task')
                        //   ListTile(
                        //     onTap: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => const HiddenBooksPage(),
                        //       ));
                        //     },
                        //     leading: Icon(
                        //       Icons.visibility_off_outlined,
                        //       color: isDark ? whiteColor : blackColor,
                        //     ),
                        //     title: Text(
                        //       "Hidden Books",
                        //       style: textStyle(
                        //         color: isDark ? whiteColor : blackColor,
                        //         fontWeight: FontWeight.w600,
                        //         size: 16,
                        //       ),
                        //     ),
                        //   ),
                        // About
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AboutPage(),
                            ));
                          },
                          leading: Icon(
                            CupertinoIcons.info,
                            color: isDark ? whiteColor : blackColor,
                          ),
                          title: Text(
                            "About",
                            style: textStyle(
                              color: isDark ? whiteColor : blackColor,
                              fontWeight: FontWeight.w600,
                              size: 16,
                            ),
                          ),
                        ),
                        // Contact
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ContactPage(),
                            ));
                          },
                          leading: Icon(
                            Icons.phone_outlined,
                            color: isDark ? whiteColor : blackColor,
                          ),
                          title: Text(
                            "Contact",
                            style: textStyle(
                              color: isDark ? whiteColor : blackColor,
                              fontWeight: FontWeight.w600,
                              size: 16,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              // height: 200,
                              width: 250,
                              child: ListTile(
                                leading: const Icon(Icons.money),
                                title: Text(
                                  'Select Currency',
                                  style: textStyle(
                                    color: isDark ? whiteColor : blackColor,
                                    fontWeight: FontWeight.w600,
                                    size: 16,
                                  ),
                                ),
                                onTap: () {
                                  showCurrencyPicker(
                                      context: context,
                                      showFlag: true,
                                      showSearchField: true,
                                      showCurrencyName: true,
                                      showCurrencyCode: true,
                                      favorite: ['PKR', 'USD'],
                                      onSelect: (Currency currencyinstate) {
                                        setState(() {
                                          _currency.text =
                                              currencyinstate.symbol;
                                          currency = currencyinstate.symbol.toString();
                                          // log('Currency : ----$currency');
                                        });
                                      },
                                      theme: CurrencyPickerThemeData(
                                          bottomSheetHeight: 500,
                                          subtitleTextStyle: const TextStyle(
                                              color: blackColor)));
                                },
                              ),
                            ),
                            Text(_currency.text),
                          ],
                        ),
                        // Theme
                        // ListTile(
                        //   onTap: () {
                        //     themeBloc.add(
                        //       themeBloc.state.isDarkTheme
                        //           ? ThemeSwitchOffEvent()
                        //           : ThemeSwitchOnEvent(),
                        //     );
                        //   },
                        //   leading: Icon(
                        //     CupertinoIcons.paintbrush,
                        //     color: isDark ? whiteColor : blackColor,
                        //   ),
                        //   title: Text(
                        //     "Dark Theme",
                        //     style: textStyle(
                        //       color: isDark ? whiteColor : blackColor,
                        //       fontWeight: FontWeight.w600,
                        //       size: 16,
                        //     ),
                        //   ),
                        //   trailing: SizedBox(
                        //     height: 22,
                        //     width: 46,
                        //     child: RepaintBoundary(
                        //       child: AnimatedToggleSwitch<bool>.rolling(
                        //         borderColor: isDark ? whiteColor : blackColor,
                        //         innerColor: isDark ? whiteColor : blackColor,
                        //         indicatorColor:
                        //             isDark ? blackColor : whiteColor,
                        //         borderWidth: 1,
                        //         current: themeBloc.state.isDarkTheme,
                        //         iconsTappable: true,
                        //         onTap: () {
                        //           themeBloc.add(
                        //             themeBloc.state.isDarkTheme
                        //                 ? ThemeSwitchOffEvent()
                        //                 : ThemeSwitchOnEvent(),
                        //           );
                        //         },
                        //         onChanged: (value) {
                        //           themeBloc.add(
                        //             themeBloc.state.isDarkTheme
                        //                 ? ThemeSwitchOffEvent()
                        //                 : ThemeSwitchOnEvent(),
                        //           );
                        //         },
                        //         values: const [false, true],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // if(widget.view=='book')    ListTile(
                        //       leading: Icon(
                        //         Icons.assignment,
                        //         color: isDark ? whiteColor : blackColor,
                        //       ),
                        //       title: Text(
                        //         "Summary",
                        //         style: textStyle(
                        //           color: isDark ? whiteColor : blackColor,
                        //           fontWeight: FontWeight.w600,
                        //           size: 16,
                        //         ),
                        //       ),
                        //       trailing: SizedBox(
                        //         height: 22,
                        //         width: 46,
                        //         child: BlocBuilder<BooksBloc, BooksState>(
                        //           builder: (context, bstate) {
                        //             return RepaintBoundary(
                        //               child: AnimatedToggleSwitch<bool>.rolling(
                        //                 borderColor:
                        //                     isDark ? whiteColor : blackColor,
                        //                 innerColor:
                        //                     isDark ? whiteColor : blackColor,
                        //                 indicatorColor:
                        //                     isDark ? blackColor : whiteColor,
                        //                 borderWidth: 1,
                        //                 current: bstate.displaySummary!,
                        //                 iconsTappable: true,
                        //                 onTap: () {
                        //                   setState(() {});
                        //                 },
                        //                 onChanged: (value) {
                        //                   context.read<BooksBloc>().add(
                        //                         SelectDisplaySummary(
                        //                           diaplaySummary: value,
                        //                         ),
                        //                       );
                        //                 },
                        //                 values: const [false, true],
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        // ListTile(

                        //   leading: Icon(
                        //     Icons.assignment,
                        //     color: isDark ? whiteColor : blackColor,
                        //   ),
                        //   title: Text(
                        //     "Summary",
                        //     style: textStyle(
                        //       color: isDark ? whiteColor : blackColor,
                        //       fontWeight: FontWeight.w600,
                        //       size: 16,
                        //     ),
                        //   ),
//                         Transform.scale(
//   scale: 0.9, // Adjust the scale value to reduce the height
//   child: FractionallySizedBox(
//     widthFactor: 0.15, // Adjust the width factor as needed
//     child: Switch.adaptive(
//       value: booksBloc.state.displaySummary!,
//       activeTrackColor: Colors.black,
//       activeColor: Colors.white,
//       inactiveTrackColor: Colors.black,
//       inactiveThumbColor: Colors.white,

//       onChanged: (value) {
//         // log(booksBloc.state.displaySummary!.toString());
//         // log('send to storage : $value');
//        setState(() {
                        //   context.read<BooksBloc>().add(
                        //   SelectDisplaySummary(
                        //     diaplaySummary: value,
                        //   ),
                        // );
//        });
//       },

//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     ),
//   ),
// )
// ),
                      ],
                    ),
                    // if(widget.view=="task")
                    Column(
                      children: [
                        // Change App
                        // ListTile(
                        //   onTap: () {
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //             const AppSelectionPage(),
                        //       ),
                        //     );
                        //   },
                        // leading: Icon(
                        //   Icons.apps_outlined,
                        //   color: isDark ? whiteColor : blackColor,
                        // ),
                        // title: Text(
                        //   "Switch Apps",
                        //   style: textStyle(
                        //     color: isDark ? whiteColor : blackColor,
                        //     fontWeight: FontWeight.w600,
                        //     size: 16,
                        //   ),
                        // ),
                        // ),
                        // Logout
                        ListTile(
                          onTap: () async {
                            Navigator.pop(context);
                            final isConfirmed = await showConfirmationDialog(
                              context,
                              "Logout?",
                              "Are you sure you want to logout?",
                              "Yes, Logout",
                              "No, Stay",
                            );
                            if (isConfirmed) {
                              await Future.delayed(
                                  const Duration(milliseconds: 0), () {
                                // widget.existingCxt
                                //     .read<BooksBloc>()
                                //     .add(const ClearCashBooks());
                                // widget.existingCxt
                                //     .read<TasksBloc>()
                                //     .add(const ClearTasksBooks());
                                widget.existingCxt
                                    .read<AuthBloc>()
                                    .add(AuthEventLogOut());

                                Navigator.of(widget.existingCxt)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const PageNavigator(),
                                ));
                              });
                            }
                          },
                          leading: Icon(
                            Icons.logout_rounded,
                            color: isDark ? whiteColor : blackColor,
                          ),
                          title: Text(
                            "Logout",
                            style: textStyle(
                              color: isDark ? whiteColor : blackColor,
                              fontWeight: FontWeight.w600,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
