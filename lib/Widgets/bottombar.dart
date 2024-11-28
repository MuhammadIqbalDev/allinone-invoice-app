import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/ItemsHome.dart';
import 'package:invoice_app/blocs/bloc/buisness_bloc.dart';
import 'package:invoice_app/blocs/bloc/invoice_bloc.dart';
import 'package:invoice_app/blocs/bloc/tax_bloc.dart';
import 'package:invoice_app/businessHome.dart';
import 'package:invoice_app/clients_home.dart';
import 'package:invoice_app/main.dart';
import 'package:invoice_app/model/addnewInvoice.dart';
import 'package:invoice_app/model/businessInfo.dart';
import 'package:invoice_app/model/clientModel.dart';
import 'package:invoice_app/model/taxModal.dart';
import 'package:invoice_app/services/storage.dart';

import '../Constants/colors.dart';
import '../blocs/bloc/client_bloc.dart';
import '../blocs/bloc/items_bloc.dart';
import '../categories.dart';
import '../invoice_home.dart';
import '../model/itemModel.dart';
import '../tax_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    getSavedData();

    super.initState();
  }

  getSavedData() async {
    List<InvoiceModel>? invoices = await Local_Storage().getInvoiceDetails();
    invoices != null
        ? context
            .read<InvoiceBloc>()
            .add(GetAllInvoice(allInvoices: invoices))
        : null;
    List<ClientModel>? clients = await Local_Storage().getClientDetails();
    clients != null
        ? context.read<ClientBloc>().add(getAllClient(clientList: clients))
        : null;

    List<AddItem>? items = await Local_Storage().getItemDetails();
    items != null
        ? context.read<ItemsBloc>().add(getAllItems(allItems: items))
        : null;
    List<Business_Info>? buisness = await Local_Storage().getBusinessDetails();
    buisness != null
        ? context.read<BuisnessBloc>().add(AllBuisness(buisnessList: buisness))
        : null;
    List<AddTax>? alltax = await Local_Storage().getTaxDetails();
    log('alltax=============---$alltax');
    // alltax != null
    // ?
    context.read<TaxBloc>().add(getAllTax(allTax: alltax!));
    // : null;
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const InvoiceHome(),
    const ClientsHome(),
    const ItemsHome(
      isModal: false,
    ),
    const TaxHome(isModal: false, tax: null),
    const BusinessHome(
      isModal: false,
    ),
    const CategoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(color: primaryExtraLight.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            backgroundColor: white,
            selectedItemColor: primary,
            unselectedItemColor: grey.withOpacity(0.7),
            iconSize: 30,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_rounded),
                label: 'Invoices',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                label: 'Clients',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Items',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_copy_outlined),
                label: 'Tax',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Categories',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
