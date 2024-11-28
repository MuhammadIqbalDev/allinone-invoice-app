import 'package:flutter/material.dart';
import 'package:invoice_app/Constants/colors.dart';

import 'Widgets/my_widgets/my_drawer.dart';
import 'invoice_home.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Categories',
          style: tstyle(size: 25,context: context, fw: FontWeight.bold),
        ),
      ),
      drawer:  MyDrawer(existingCxt: context),
      body: const Center(
          child: Text(
        'Coming Soon....',
        style: TextStyle(
          color: blackColor,
          fontSize: 25,
        ),
      )),
    );
  }
}
