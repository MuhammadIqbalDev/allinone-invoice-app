// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:muhasba/models/taskbook.dart';
// import '../../blocs/bloc_exports.dart';
// import '../../constants/colors.dart';
// import '../../helpers/methods.dart';
// import '../../models/book.dart';
// import '../../utilities/dialogs/books_list_sheet.dart';

// AppBar myAppBar({
//   required BuildContext context,
//   required GlobalKey<ScaffoldState> scaffoldKey,
//   required String view,
//   Book? book,
//   TaskBook? taskBook,
// }) {
//   bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
//   return AppBar(
//     leadingWidth: 46,
//     toolbarHeight: 60,
//     elevation: 0,
//     scrolledUnderElevation: 0,
//     backgroundColor: isDark ? blackColor : whiteColor,
//     title: SizedBox(
//       height: 56,
//       child: InkWell(
//         overlayColor: MaterialStatePropertyAll(
//           isDark ? whiteColor.withAlpha(30) : greyColor.withAlpha(30),
//         ),
//         borderRadius: BorderRadius.circular(6),
//         onTap: () {
//           showBooksSheet(context, view);
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(width: 2),
//             showIcon(
//               viewProvider(
//                 view: view,
//                 forBook: FontAwesomeIcons.book,
//                 forTask: CupertinoIcons.square_list_fill,
//               ),
//               isDark,
//               viewProvider(
//                 view: view,
//                 forBook: null,
//                 forTask: 30.0,
//               ) as double?,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BlocBuilder<BooksBloc, BooksState>(
//                     builder: (context, state) {
//                       List<Book> bklist = state.allBooks
//                           .where(
//                               (element) => element.id == state.selectedBookId)
//                           .toList();
//                       Book? book;
//                       if (bklist.isNotEmpty) {
//                         book = bklist.first;
//                       }

//                       return Text(
//                         viewProvider(
//                           view: view,
//                           forBook: book!=null ? book.name : "Select Cash Book",
//                           forTask: taskBook!=null ? taskBook.bookName : "Select Task Book",
//                         ) as String,
//                         style: textStyle(
//                           color: isDark ? whiteColor : greyColor,
//                           fontWeight: FontWeight.bold,
//                           size: 16,
//                         ),
//                       );
//                     },
//                   ),
//                   if (book != null || taskBook != null)
//                     Text(
//                       book?.remarks ?? taskBook?.remarks ?? "",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: textStyle(
//                         color: isDark
//                             ? whiteColor.withAlpha(150)
//                             : greyColor.withAlpha(150),
//                         fontWeight: FontWeight.w500,
//                         size: 11,
//                       ),
//                     )
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             showIcon(Icons.keyboard_arrow_down_sharp, isDark, null),
//           ],
//         ),
//       ),
//     ),
//     leading: IconButton(
//       splashRadius: 24,
//       onPressed: () {
//         scaffoldKey.currentState!.openDrawer();
//       },
//       icon: showIcon(Icons.menu_rounded, isDark, null),
//     ),
//   );
// }
