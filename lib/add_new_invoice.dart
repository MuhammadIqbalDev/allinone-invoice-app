// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:invoice_app/ItemsHome.dart';
import 'package:invoice_app/Widgets/textFormFieldWidget.dart';
import 'package:invoice_app/blocs/bloc/buisness_bloc.dart';
import 'package:invoice_app/model/businessInfo.dart';
import 'package:invoice_app/model/itemModel.dart';
import 'package:invoice_app/pdf_preview_page.dart';
import 'package:invoice_app/tax_home.dart';

import 'Constants/colors.dart';
import 'Widgets/my_widgets/my_drawer.dart';
import 'blocs/bloc/client_bloc.dart';
import 'blocs/bloc/invoice_bloc.dart';
import 'blocs/bloc/items_bloc.dart';
import 'blocs/bloc/tax_bloc.dart';
import 'businessHome.dart';
import 'clients_home.dart';
import 'invoice_home.dart';
import 'model/addnewInvoice.dart';
import 'model/clientModel.dart';
import 'newClient.dart';

class NewInvoice extends StatefulWidget {
  final InvoiceModel? EditingInvoice;
  const NewInvoice({
    super.key,
    required this.EditingInvoice,
  });

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

Business_Info? selected_business;
ClientModel? selected_client;
InvoiceModel? created_invoice;
bool selectingDueDate = false;

class _NewInvoiceState extends State<NewInvoice> {
  XFile? _pickedImage;
  final TextEditingController issuedateController = TextEditingController();
  final TextEditingController duedateController = TextEditingController();
  final TextEditingController _textFieldNameController =
      TextEditingController();
  final TextEditingController _textFieldAmountController =
      TextEditingController();
  final TextEditingController _textFieldAddressController =
      TextEditingController();
  final TextEditingController _textFieldPhoneController =
      TextEditingController();
  final TextEditingController _textFieldEmailController =
      TextEditingController();
  final TextEditingController _textFieldItemNameController =
      TextEditingController();
  final TextEditingController _textFieldDescriptionController =
      TextEditingController();
  final TextEditingController _textFieldUnitPriceController =
      TextEditingController();
  final TextEditingController _textFieldUnitController =
      TextEditingController();
  final TextEditingController _textFieldQuantityController =
      TextEditingController();
  final TextEditingController _textFieldCategoryController =
      TextEditingController();
  final TextEditingController _textFieldSubtotalController =
      TextEditingController();

  final TextEditingController _textFieldRateController =
      TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime issueDate = DateTime.now();
  DateTime dueDate = DateTime.now();

  List<String> discount = <String>['No Discount', 'On total', 'Per item'];
  String dropdownvalue = 'On total';

  List<String> Type = <String>['Percentage', 'Flat Amount'];
  String dropdownvalue2 = 'Percentage';
  double discountpercent = 0.0;

  @override
  void initState() {
    if (widget.EditingInvoice != null) {
      context
          .read<ItemsBloc>()
          .add(SelectedItems(selectedItem: widget.EditingInvoice!.items));
      context
          .read<BuisnessBloc>()
          .add(selectedBuisness(sb: widget.EditingInvoice!.business));
      context
          .read<ClientBloc>()
          .add(selectedClient(Sc: widget.EditingInvoice!.Client));
    }
    issuedateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    duedateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    // _textFieldDescriptionController.text=TextEditingController(text: 'Initial value') as String;
    super.initState();
  }

  int startInvoiceNumber = 1;
  int endInvoiceNumber = 10;

  // double result = 0;

  List<String> unit = <String>[];
  // ['Kg', 'lb'];
  String Unitdropdownvalue = 'kg';

  List<String> tax = <String>['No tax', 'On total', 'Per item'];
  String dropdownvalue1 = 'No tax';

  void _saveData() {
    // Implement your save logic here
    // This method will be called when the "Save" button is clicked
  }

  String currentDate = DateTime.now().toString();
  //  DateFormat('yyyy,MM,dd').format();
  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  @override
  void dispose() {
    _textFieldNameController.dispose();
    _textFieldAddressController.dispose();
    _textFieldEmailController.dispose();
    _textFieldPhoneController.dispose();
    issuedateController.dispose();
    duedateController.dispose();
    super.dispose();
  }

  void _selectDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 300.0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      // Do something with selectedDate
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                dateOrder: DatePickerDateOrder.dmy,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    // _selectedDateTime = dateTime;
                    selectedDate = dateTime;

                    if (selectingDueDate) {
                      dueDate = dateTime;

                      duedateController.text =
                          DateFormat("dd/MM/yyyy").format(dueDate);
                    } else {
                      issueDate = dateTime;
                      issuedateController.text =
                          DateFormat("dd/MM/yyyy").format(issueDate);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToClear(BuildContext context) {
    context.read<BuisnessBloc>().add(selectedBuisness(sb: null));
    context.read<ClientBloc>().add(selectedClient(Sc: null));
    context.read<ItemsBloc>().add(defaultSelected());
  }

  Map<String, double> getSubtotal(
      {required List<AddItem> allitems,
      required double discount,
      required double tax,
      required bool tperItem,
      required bool dperItem,
      required bool noTax,
      required bool tonTotal,
      required bool noDiscount,
      required bool donTotal,
      required bool flatamount}) {
    // double discountpercent = 0;

    log("disPercentage =====================: $discountpercent");
    log("No Discount =====================: $noDiscount");
    log("Flat Amount =====================: $flatamount");
    log("discount item ------------------ :$dperItem");
    log("Discount on total ------------------ :$donTotal");
    log("TaxPercentage =====================: $tax");
    log("No Tax =====================: $noTax");
    // log("Flat Amount =====================: $flatamount");
    log("Tax p item ------------------ :$tperItem");
    log("Tax on total ------------------ :$tonTotal");

    double taxpercent = 0;
    double subtotal = 0.0;
    double total = 0.0;
    double finalDiscount = 0;

    for (AddItem element in allitems) {
      subtotal += element.total;
      // Tax for per Item
      if (tperItem) {
        taxpercent += (tax * element.total) / 100;
      }
      // Discount for per item and Percentage
      if (dperItem && dropdownvalue2 == 'Percentage') {
        finalDiscount +=
            (discount * (element.unitPrice * element.quantity)) / 100;
      }
      // Discount for per item and flat amount

      if (dperItem && dropdownvalue2 == 'Flat Amount') {
        finalDiscount += (discount);
        log('ONTHEdISCSDFSD --------:DISCOUNT :  $discount $finalDiscount');
      }
    }
    log('unit price percentage --------???: $finalDiscount');
    log(' percentage --------???: $discount');

    finalDiscount = noDiscount
        ? 0
        : flatamount
            ? finalDiscount
            : !dperItem
                ? (discount * subtotal) / 100
                : finalDiscount;

    log('getted discount percentage selected from pop up :$discount');
    log("getted discount : $finalDiscount");

    taxpercent = noTax
        ? 0
        : !tperItem
            ? (tax * subtotal) / 100
            : taxpercent;
    log("taxpercent : $tax --- $taxpercent");

    total = subtotal - finalDiscount + taxpercent;

    return {
      'subtotal': subtotal,
      'total': total,
      'discount': finalDiscount,
      'tax': taxpercent
    };
  }

  Map overall = {};

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double hieght = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: blackColor,
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
              _proceedToClear(context);
            },
          ),
          title: Text(
            'Add new invoice',
            style: tstyle(size: 20, context: context, fw: FontWeight.w600),
          ),
          actions: [
            BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, invoices) {
                return BlocBuilder<BuisnessBloc, BuisnessState>(
                  builder: (context, busniss) {
                    return BlocBuilder<TaxBloc, TaxState>(
                      builder: (context, tstate) {
                        log('${tstate.selectedTax}');
                        return BlocBuilder<ClientBloc, ClientState>(
                          builder: (context, clients) {
                            return BlocBuilder<ItemsBloc, ItemsState>(
                                builder: (context, items) {
                              return (items.selectedItems.isNotEmpty &&
                                      clients.Sc != null &&
                                      busniss.sb != null)
                                  ? TextButton(
                                      onPressed: () {
                                        InvoiceModel createdinvoice =
                                            InvoiceModel(
                                                widget.EditingInvoice != null
                                                    ? widget.EditingInvoice!
                                                        .invoice_id
                                                    : invoices.invoiceList
                                                            .isNotEmpty
                                                        ? invoices
                                                                .invoiceList
                                                                .last
                                                                .invoice_id +
                                                            1
                                                        : 1,
                                                busniss.sb!,
                                                clients.Sc!,
                                                items.selectedItems,
                                                overall['subtotal'],
                                                overall['total'],
                                                overall['tax'],
                                                overall['discount'],
                                                DateTime.now(),
                                                issueDate,
                                                dueDate);
                                        if (widget.EditingInvoice != null) {
                                          context.read<InvoiceBloc>().add(
                                              EditInvoices(
                                                  editInvoice: createdinvoice));
                                        } else {
                                          {
                                            context.read<InvoiceBloc>().add(
                                                AddInvoice(
                                                    invoice: createdinvoice));
                                            context.read<InvoiceBloc>().add(
                                                SelectedInvoice(
                                                    selectedInvoice:
                                                        createdinvoice));
                                          }
                                        }
                                        _proceedToClear(context);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "SAVE",
                                        style: tstyle(
                                          context: context,
                                          size: 16,
                                          fw: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ))
                                  : const SizedBox();
                            });
                          },
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
        drawer: MyDrawer(existingCxt: context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: BlocBuilder<TaxBloc, TaxState>(
              builder: (context, tstate) {
                return BlocBuilder<ItemsBloc, ItemsState>(
                  builder: (context, istate) {
                    // log("kdeejdedoedjo---------${tstate.selectedTax}");
                    overall = getSubtotal(
                        allitems: istate.selectedItems,
                        discount: discountpercent,
                        tax: tstate.selectedTax.taxPercentage,
                        tperItem: (tstate.selectedTax.taxType == 'Per item'),
                        dperItem: (dropdownvalue == 'Per item'),
                        noTax: (tstate.selectedTax.taxType == 'No tax'),
                        tonTotal: (tstate.selectedTax.taxType == 'On total'),
                        noDiscount: (dropdownvalue == 'No Discount'),
                        donTotal: (dropdownvalue == 'On total' &&
                            dropdownvalue2 == 'Percentage'),
                        flatamount: (dropdownvalue2 == "Flat Amount"));
                    return BlocBuilder<InvoiceBloc, InvoiceState>(
                      builder: (context, state) {
                        int id = widget.EditingInvoice != null
                            ? widget.EditingInvoice!.invoice_id
                            : state.invoiceList.length + 1;
                        return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: Main,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(50.0),
                                          ),
                                        ),
                                        context: context,
                                        builder: ((context) =>
                                            const BusinessHome(
                                              isModal: true,
                                            )));
                                  },
                                  child:
                                      BlocBuilder<BuisnessBloc, BuisnessState>(
                                          builder: (context, bstate) {
                                    selected_business = bstate.sb;

                                    return bstate.sb == null
                                        ? DottedBorder(
                                            color: grey.withOpacity(0.8),
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(10),
                                            dashPattern: const [5, 2],
                                            strokeWidth: 1,
                                            child: Container(
                                              // width: width * 0.4,
                                              height: hieght * 0.17,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Center(
                                                child: Text(
                                                  '+ Add Business Information',
                                                  style: tstyle(
                                                      context: context,
                                                      size: 20,
                                                      color:
                                                          grey.withOpacity(0.7),
                                                      fw: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(bstate.sb!.name,
                                                overflow: TextOverflow.ellipsis,
                                                    style: tstyle(
                                                      size: 23,
                                                      context: context,
                                                    )),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  bstate.sb!.email,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: tstyle(
                                                    context: context,
                                                    size: 20,
                                                    // color:
                                                    //     black.withOpacity(0.8)
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                  }),
                                ),
                                Divider(
                                  color: greyLight,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "BILL TO",
                                            style: TextStyle(
                                              color: primary,
                                            ),
                                          ),
                                          Text(
                                            "INVOICE INFO",
                                            style: TextStyle(color: primary),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            50.0),
                                                      ),
                                                    ),
                                                    context: context,
                                                    builder: ((context) =>
                                                        const ClientsHome(
                                                          isModal: true,
                                                        )));
                                              },
                                              child: BlocBuilder<ClientBloc,
                                                      ClientState>(
                                                  builder: (context, state) {
                                                selected_client = state.Sc;
                                                return state.Sc == null
                                                    ? DottedBorder(
                                                        color: grey
                                                            .withOpacity(0.8),
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius: const Radius
                                                            .circular(10),
                                                        dashPattern: const [
                                                          5,
                                                          2
                                                        ],
                                                        strokeWidth: 1,
                                                        child: Container(
                                                          width: width * 0.4,
                                                          height: hieght * 0.17,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          child: Center(
                                                            child: Text(
                                                              '+ Add client',
                                                              style: tstyle(
                                                                  context:
                                                                      context,
                                                                  size: 20,
                                                                  color: grey
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fw: FontWeight
                                                                      .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: width * 0.4,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                state.Sc!
                                                                    .clientName,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: tstyle(
                                                                  context:
                                                                      context,
                                                                  size: 16,
                                                                )),
                                                            Text(
                                                              state.Sc!
                                                                  .clientEmail,
                                                              // overflow: TextOverflow.ellipsis,
                                                              // softWrap: true,
                                                              // maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: tstyle(
                                                                context:
                                                                    context,
                                                                size: 16,
                                                                // color: black
                                                                //     .withOpacity(
                                                                //         0.8)
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                              }),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "INV#${id < 10 ? '00$id' : id < 100 ? '0$id' : id}",
                                                  textAlign: TextAlign.end,
                                                  style: tstyle(
                                                      context: context,
                                                      size: 17),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            // height: 100,
                                            width: 100,
                                            child: CustomTextFormField(
                                              focusnode:
                                                  AlwaysDisabledFocusNode(),
                                              labelText: 'Issue Date:',
                                              controller: issuedateController,
                                              // labelText: "N",
                                              onTap: () {
                                                selectingDueDate = false;
                                                _selectDate();
                                              },
                                            ),
                                          ),
                                          //  SizedBox(

                                          //   height: 150,
                                          //   width: 150,
                                          //    child: MyTextFormField(
                                          //      controller: dateController,
                                          //      onTap: () {
                                          //        // );
                                          //        _selectDate();
                                          //      },
                                          //      hintText: "Tap here",
                                          //      errorText:
                                          //          "Select date please",
                                          //      validator: null,
                                          //    ),
                                          //  ),
                                          // Text(
                                          //   "Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                                          //   textAlign: TextAlign.end,
                                          //   style: tstyle(
                                          //     context: context,
                                          //     size: 15,
                                          //     // color: black
                                          //     // .withOpacity(0.6)
                                          //   ),
                                          // ),
                                          // Text(
                                          //   "Due date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                                          //   textAlign: TextAlign.end,
                                          //   style: tstyle(
                                          //     size: 15,
                                          //     context: context,
                                          //     // color: black
                                          //     //     .withOpacity(0.6)
                                          //   ),
                                          // ),
                                          SizedBox(
                                            // height: 100,
                                            width: 100,
                                            child: CustomTextFormField(
                                              // enabled: false,
                                              focusnode:
                                                  AlwaysDisabledFocusNode(),
                                              //  enableInteractiveSelection:false,
                                              labelText: 'Due Date:',
                                              controller: duedateController,
                                              // labelText: "N",
                                              onTap: () {
                                                selectingDueDate = true;
                                                _selectDate();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Divider(
                                        color: greyLight,
                                      ),
                                      Positioned(
                                          left: 0,
                                          bottom: -2,
                                          child: Text(
                                            "ITEMS ",
                                            style: TextStyle(
                                              color: primary,
                                              backgroundColor: whiteColor,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),

                                istate.selectedItems.isNotEmpty
                                    ? Column(
                                        children: [
                                          ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  istate.selectedItems.length,
                                              itemBuilder: (context, index) {
                                                AddItem eachItem =
                                                    istate.selectedItems[index];
                                                log('Item-----------${istate.item}');
                                                return InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 92,
                                                                child: Text(
                                                                  eachItem
                                                                      .itemName,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      
                                                                  style: tstyle(
                                                                    context:
                                                                        context,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width * 0.3,
                                                              ),
                                                              SizedBox(
                                                                width: 70,
                                                                child: Text(
                                                                    "$currency${eachItem.unitPrice * eachItem.quantity}",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    ),
                                                              ),

                                                              // Text("${client['Address']}"),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                                width: 150,
                                                                child: Text(
                                                                  eachItem
                                                                      .description,
                                                                      overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                  style: tstyle(
                                                                    context:
                                                                        context,
                                                                  ),
                                                                ),),
                                                          SizedBox(
                                                            width: 150,
                                                            child: Text(
                                                              "$currency${eachItem.unitPrice} X ${eachItem.quantity}${eachItem.unit}",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: tstyle(
                                                                  context:
                                                                      context,
                                                                  color: grey
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                          ),

                                                          // const Text(''),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                left: BorderSide(
                                                                    color: grey
                                                                        .withOpacity(
                                                                            0.8)))),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: primary,
                                                          ),
                                                          onPressed: () {
                                                            log('Stateallitems-----------${istate.allItem}');
                                                            log('eachitem-----------$eachItem');
                                                            context
                                                                .read<
                                                                    ItemsBloc>()
                                                                .add(DeleteSelectedItems(
                                                                    eachItem));
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                          const SizedBox(
                                            height: 13,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(3),
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: ((context) =>
                                                        const ItemsHome(
                                                          isModal: true,
                                                        )));
                                              },
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  '+ Add line item',
                                                  textAlign: TextAlign.start,
                                                  style: tstyle(
                                                      context: context,
                                                      size: 18,
                                                      color: primary,
                                                      fw: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      )
                                    : Container(
                                        margin: const EdgeInsets.all(5),
                                        child: DottedBorder(
                                            color: grey.withOpacity(0.8),
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(10),
                                            dashPattern: const [5, 2],
                                            strokeWidth: 1,
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: ((context) =>
                                                        const ItemsHome(
                                                          isModal: true,
                                                        )));
                                              },
                                              child: Center(
                                                child: Container(
                                                    width: width * 0.9,
                                                    height: hieght * 0.17,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Center(
                                                        child: Text(
                                                      '+ Add line item',
                                                      style: tstyle(
                                                          context: context,
                                                          size: 20,
                                                          color: grey
                                                              .withOpacity(0.7),
                                                          fw: FontWeight.w500),
                                                    ))),
                                              ),
                                            )),
                                      ),

                                const SizedBox(
                                  height: 10,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                // ListView.builder(
                                //     shrinkWrap: true,
                                //     itemCount: allItems.length,
                                //     itemBuilder: (context, index) {
                                //       return InkWell(
                                //         onTap: () {},
                                //         child: Container(
                                //           child: const Column(
                                //             crossAxisAlignment: CrossAxisAlignment.start,
                                //             children: [
                                //               Row(
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment.spaceBetween,
                                //                 children: [
                                //                   Text("item name"),
                                //                   Text("quantity"),
                                //                 ],
                                //               ),
                                //               Text("decsription"),
                                //               Text("unit price"),
                                //               Divider(),
                                //             ],
                                //           ),
                                //         ),
                                //       );
                                //     }),

                                // NewItem(
                                //   buisness: buisness,
                                //   client: selectedClient!,
                                //   invoice_id: invoiceId,
                                // ),

                                BlocBuilder<ItemsBloc, ItemsState>(
                                  builder: (context, state) {
                                    return state.selectedItems.isNotEmpty
                                        ? Container(
                                            width: width,
                                            padding: const EdgeInsets.all(0.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  greyLight))),
                                                  width: width * 0.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Subtotal",
                                                            style: tstyle(
                                                                context:
                                                                    context,
                                                                size: 15,
                                                                fw: FontWeight
                                                                    .bold),
                                                          ),
                                                          // const SizedBox(
                                                          //   width: 50,
                                                          // ),
                                                          Text(
                                                            '$currency${overall['subtotal'].toStringAsFixed(2)}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.6,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  greyLight))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              content: StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                return Form(
                                                                    child:
                                                                        Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                        "Discount"),
                                                                    DropdownButton<
                                                                        String>(
                                                                      value:
                                                                          dropdownvalue,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        // This is called when the user selects an item.
                                                                        setState(
                                                                            () {
                                                                          dropdownvalue =
                                                                              value!;
                                                                        });
                                                                      },
                                                                      items: discount.map<
                                                                          DropdownMenuItem<
                                                                              String>>((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child:
                                                                              Text(value),
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                    const Text(
                                                                        "Type"),
                                                                    DropdownButton<
                                                                        String>(
                                                                      value:
                                                                          dropdownvalue2,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        // log('dropdownvalue : $value');
                                                                        // This is called when the user selects an item.
                                                                        setState(
                                                                            () {
                                                                          dropdownvalue2 =
                                                                              value!;
                                                                        });
                                                                      },
                                                                      items: Type.map<
                                                                          DropdownMenuItem<
                                                                              String>>((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child:
                                                                              Text(value),
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                    const Text(
                                                                        'Amount'),
                                                                    SizedBox(
                                                                      // width: 200,
                                                                      // height: 200,
                                                                      child:
                                                                          TextFormField(
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        controller:
                                                                            _textFieldAmountController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          prefixText: (dropdownvalue2 == "Flat Amount")
                                                                              ? "\$"
                                                                              : null,
                                                                          suffixText: (dropdownvalue2 != "Flat Amount")
                                                                              ? "%"
                                                                              : null,
                                                                        ),
                                                                      ),
                                                                    ), // )
                                                                  ],
                                                                ));
                                                              }),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          color:
                                                                              primary),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                        () {
                                                                          discountpercent =
                                                                              double.parse(_textFieldAmountController.text);
                                                                          overall = getSubtotal(
                                                                              allitems: istate.selectedItems,
                                                                              discount: discountpercent,
                                                                              tax: tstate.selectedTax.taxPercentage,
                                                                              tperItem: (tstate.selectedTax.taxType == 'per item'),
                                                                              dperItem: (dropdownvalue == 'per item'),
                                                                              noTax: (tstate.selectedTax.taxType == 'No tax'),
                                                                              tonTotal: (tstate.selectedTax.taxType == 'On total'),
                                                                              noDiscount: (dropdownvalue == 'No Discount'),
                                                                              donTotal: (dropdownvalue == 'On total' && dropdownvalue2 == 'Percentage'),
                                                                              flatamount: (dropdownvalue2 == "Flat Amount"));
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      );
                                                                    })
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: SizedBox(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width * 0.4,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Text(
                                                                      "Discount(",
                                                                      style: tstyle(
                                                                          context:
                                                                              context,
                                                                          size:
                                                                              15,
                                                                          fw: FontWeight
                                                                              .bold),
                                                                    ),
                                                                    Text(
                                                                      (dropdownvalue ==
                                                                              'No Discount')
                                                                          ? '0.0'
                                                                          : (dropdownvalue2 == 'Flat Amount')
                                                                              ? "$currency$discountpercent"
                                                                              : "$discountpercent %",
                                                                      style: tstyle(
                                                                          context:
                                                                              context,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              black.withOpacity(0.5)),
                                                                    ),
                                                                    Text(
                                                                      ")",
                                                                      style: tstyle(
                                                                          context:
                                                                              context,
                                                                          size:
                                                                              15,
                                                                          fw: FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                overall['discount']
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    // log('taxpercentage---------------${tstate.selectedTax.taxPercentage}');
                                                    showModalBottomSheet(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    50.0),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: ((context) =>
                                                            const TaxHome(
                                                              isModal: true,
                                                              tax: null,
                                                            )));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    greyLight))),
                                                    width: width * 0.6,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                child: Row(
                                                              children: [
                                                                Text(
                                                                  "Tax(",
                                                                  style: tstyle(
                                                                      context:
                                                                          context,
                                                                      size: 15,
                                                                      fw: FontWeight
                                                                          .bold),
                                                                ),
                                                                Text(
                                                                  "${tstate.selectedTax.taxType == 'No tax' ? 0.0 : tstate.selectedTax.taxPercentage} %",
                                                                  style: tstyle(
                                                                      context:
                                                                          context,
                                                                      size: 15,
                                                                      color: black
                                                                          .withOpacity(
                                                                              0.5)),
                                                                ),
                                                                Text(
                                                                  ")",
                                                                  style: tstyle(
                                                                      context:
                                                                          context,
                                                                      size: 15,
                                                                      fw: FontWeight
                                                                          .bold),
                                                                ),
                                                              ],
                                                            )),
                                                            Container(
                                                              child: Text(
                                                                overall['tax']
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  greyLight))),
                                                  width: width * 0.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Total",
                                                            style: tstyle(
                                                                context:
                                                                    context,
                                                                size: 15,
                                                                fw: FontWeight
                                                                    .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 50,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              '$currency${overall['total'].toStringAsFixed(2)}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                ),
                                const SizedBox(
                                  height: 60,
                                )
                              ],
                            ));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocBuilder<BuisnessBloc, BuisnessState>(
          builder: (context, busniss) {
            return BlocBuilder<ClientBloc, ClientState>(
              builder: (context, clients) {
                return BlocBuilder<ItemsBloc, ItemsState>(
                    builder: (context, items) {
                  return (items.selectedItems.isNotEmpty &&
                          clients.Sc != null &&
                          busniss.sb != null)
                      ? BlocBuilder<InvoiceBloc, InvoiceState>(
                          builder: (context, invoice) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              height: hieght * 0.15,
                              // width: width*0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary,
                              ),
                              child: InkWell(
                                onTap: () {
                                  
                                  // log("Due date :${invoice.selectedInvoices.duedate}");
                                  created_invoice = InvoiceModel(
                                      invoice.invoiceList.isNotEmpty
                                          ? invoice
                                                  .invoiceList.last.invoice_id +
                                              1
                                          : 1,
                                      busniss.sb!,
                                      clients.Sc!,
                                      items.selectedItems,
                                      overall['subtotal'],
                                      overall['total'],
                                      overall['tax'],
                                      overall['discount'],
                                      DateTime.now(),
                                      issueDate,
                                      dueDate,
                                      // DateTime.now(),
                                      // DateTime.now(),
                                      );
                                  
                                  if (created_invoice != null) {
                                    // context.read<InvoiceBloc>().add(
                                    //     AddInvoice(
                                    //         invoice: created_invoice!));
                                    context.read<InvoiceBloc>().add(
                                        SelectedInvoice(
                                            selectedInvoice: created_invoice!));
                                  }
                                  if (invoice.selectedInvoices != null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return PdfPreviewPage(
                                        invoice: invoice.selectedInvoices!,
                                      );
                                    }));
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.print_outlined,
                                      color: white,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Print Invoice',
                                      style: tstyle(
                                          context: context,
                                          size: 20,
                                          color: white),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const SizedBox();
                });
              },
            );
          },
        ));
  }

  void _showAddItemPopup(BuildContext context) {
    TextEditingController addItemController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: addItemController,
            decoration: const InputDecoration(labelText: 'Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newItem = addItemController.text;
                if (newItem.isNotEmpty) {
                  setState(() {
                    unit.add(newItem);
                    Unitdropdownvalue =
                        newItem; // Select the newly added item in dropdown
                  });
                  Navigator.pop(context); // Close the popup
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
