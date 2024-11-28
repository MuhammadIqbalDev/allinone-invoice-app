// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_app/add_new_invoice.dart';
import 'package:invoice_app/blocs/bloc/invoice_bloc.dart';

import 'Constants/colors.dart';
import 'Widgets/my_widgets/my_drawer.dart';
import 'blocs/theme_switch_bloc/theme_switch_bloc.dart';
import 'model/addnewInvoice.dart';

class InvoiceHome extends StatefulWidget {
  // final bool isModal;
  const InvoiceHome({
    Key? key,
    // required this.isModal,
  }) : super(key: key);

  @override
  State<InvoiceHome> createState() => _InvoiceHomeState();
}

List<List> items = [];

class _InvoiceHomeState extends State<InvoiceHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<ThemeSwitchBloc, ThemeSwitchState>(
      builder: (context, state) {
        bool isDark = state.isDarkTheme;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Invoices',
              style: tstyle(size: 25,context: context, fw: FontWeight.bold),
            ),
          ),
          drawer: MyDrawer(existingCxt: context),
          body:
              BlocBuilder<InvoiceBloc, InvoiceState>(builder: (context, state) {
            return Container(
                child: state.invoiceList.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.invoiceList.length,
                        itemBuilder: (context, index) {
                          InvoiceModel invoice = state.invoiceList[index];
                          return InkWell(
                              onTap: () {
                                // Navigator.of(context).pop();
                                context.read<InvoiceBloc>().add(
                                    SelectedInvoice(selectedInvoice: invoice));
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return NewInvoice(
                                    EditingInvoice: invoice,
                                  );
                                })));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Container(
                                        //   margin: const EdgeInsets.all(5),
                                        //   width: width * 0.2,
                                        //   height: width * 0.2,
                                        //   decoration: BoxDecoration(
                                        //     color: greyLight.withOpacity(0.4),
                                        //     borderRadius:
                                        //         BorderRadius.circular(10),
                                        //   ),
                                        //   child: Center(
                                        //       child: Text(
                                        //     invoice.Client.clientName[0]
                                        //         .toUpperCase(),
                                        //     style: tstyle(
                                        //         color: black,
                                        //         context: context,
                                        //         size: 40,
                                        //         fw: FontWeight.bold),
                                        //   )),
                                        // ),
                                        // const SizedBox(width: 5,),
                                        SizedBox(
                                          width: width * 0.3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${invoice.business.name[0].toUpperCase()}${invoice.business.name.substring(1)}",
                                                overflow: TextOverflow.ellipsis,
                                                style: tstyle(
                                                    fw: FontWeight.w500,
                                                    context: context,
                                                    size: 20),
                                              ),
                                              Text(
                                                "Client: ${invoice.Client.clientName[0].toUpperCase()}${invoice.Client.clientName.substring(1)}",
                                                overflow: TextOverflow.ellipsis,
                                                style: tstyle(
                                                    fw: FontWeight.w400,
                                                    context: context,
                                                    size: 20),
                                              ),
                                              Text(
                                                ('Invoice#${invoice.invoice_id.toString()}'),
                                                textAlign: TextAlign.end,
                                                style: tstyle(
                                                    fw: FontWeight.w300,
                                                    context: context,
                                                    size: 17),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "\$${invoice.total}",
                                                  style: tstyle(
                                                      fw: FontWeight.w500,
                                                      context: context,
                                                      size: 20),
                                                ),
                                                // Text(
                                                //   item.unit,
                                                //   style: tstyle(
                                                //       fw: FontWeight.w300, size: 17),
                                                // ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: 60,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black))),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: primary,
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<InvoiceBloc>()
                                                      .add(DeleteInvoices(
                                                          invoice));
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: greyLight,
                                    )
                                  ],
                                ),
                              ));
                        })
                    : Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: hieght * 0.4,
                                child: Image(
                                  image: const AssetImage(
                                      'assets/images/noinvoice.png'),
                                  height: hieght * 0.3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No invoices!",
                                  style: tstyle(
                                      color: !isDark ? blackColor : whiteColor,
                                      context: context,
                                      size: 25,
                                      fw: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Please tap on the plus (+) button bellow to create an invoice.",
                                  style: tstyle(
                                    size: 20,
                                    color: !isDark ? blackColor : whiteColor,
                                    // color: grey.withOpacity(0.8),
                                    context: context
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
          }),
          floatingActionButton: SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Customize the border radius here
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const NewInvoice(
                    EditingInvoice: null,
                  );
                }));
              },

              child: Icon(
                Icons.add,
                color: white,
                size: 30,
              ), // Customize the button color here
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

TextStyle tstyle({
  double? size,
  Color? color,
  FontWeight? fw,
  required BuildContext context,
}) {
  //  bool isDark = context.read<ThemeSwitchState>().isDarkTheme;

  return TextStyle(
    fontSize: size ?? 15,
    color: color?? blackColor,
    fontWeight: fw ?? FontWeight.normal,
  );
}
