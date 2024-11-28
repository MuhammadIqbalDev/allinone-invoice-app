
// import 'package:flutter/material.dart';
// import 'package:muhasba/pages/home/revenue_book/views/assets_screen.dart';
// import 'package:muhasba/pages/home/revenue_book/views/capital_screen.dart';
// import 'package:muhasba/pages/home/revenue_book/views/expense_screen.dart';
// import 'package:muhasba/pages/home/revenue_book/views/liabilities_screen.dart';
// import 'package:muhasba/pages/home/revenue_book/views/revenue_screen.dart';

// import '../../constants/colors.dart';
// import '../../pages/home/revenue_book/views/category_screen.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: BottomNavBar(),
//     );
//   }
// }

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   @override
//   void initState() {
//     getSavedData();

//     super.initState();
//   }

//   getSavedData() async {
//   }

//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const RevenueScreen(),
//     const ExpenseScreen(),
//     const AssetsScreen(),
//     const CapitalScreen(),
//     const LiabilitiesScreen(),
//     const CategoryScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
//         decoration: BoxDecoration(
//           border: Border.all(color:Colors.grey.withOpacity(0.5)),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: BottomNavigationBar(
//             backgroundColor: whiteColor,
//             selectedItemColor: redDarkColor,
//             unselectedItemColor: greyColor,
//             // iconSize: 10,
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/revenuebook/revenue.png',height: 30,width: 30,),
//                 label: 'Revenue',
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/revenuebook/expense.png',height: 30,width: 30,),
//                 label: 'Expense',
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/revenuebook/assets.png',height: 30,width: 30,),
//                 label: 'Assets',
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/revenuebook/capital.png',height: 30,width: 30,),
//                 label: 'Capital',
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/revenuebook/liability.png',height: 30,width: 30,),
//                 label: 'Liabilites',
//               ),
//               const BottomNavigationBarItem(
//                 icon: Icon(Icons.category_outlined),
//                 label: 'Categories',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
