// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/blocs/bloc/buisness_bloc.dart';

import 'Constants/colors.dart';
import 'Widgets/my_widgets/my_drawer.dart';
import 'business_info.dart';
import 'invoice_home.dart';
import 'model/businessInfo.dart';

class BusinessHome extends StatefulWidget {
  final bool? isModal;
  const BusinessHome({
    Key? key,
   required this.isModal,
  }) : super(key: key);

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  bool isModal = false;
  @override
  void initState() {
    isModal = widget.isModal ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Business',
          style: tstyle(size: 25,context: context, fw: FontWeight.bold),
        ),
      ),
      drawer: !isModal? MyDrawer(existingCxt: context,):null,
      body: BlocBuilder<BuisnessBloc, BuisnessState>(builder: (context, state) {
        return Container(
            padding: const EdgeInsets.all(10),
            child: state.businessList.isNotEmpty
                ? ListView.builder(
                    itemCount: state.businessList.length,
                    itemBuilder: (context, index) {
                      Business_Info businessl = state.businessList[index];
                      log("buisness : $businessl");

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if (isModal) {
                                context
                                    .read<BuisnessBloc>()
                                    .add(selectedBuisness(sb: businessl));
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return BusinessInfo(
                                      EditingBusiness: businessl);
                                })));
                              }
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                      color: greyLight.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text(
                                      businessl.name.isNotEmpty
                                          ? businessl.name[0].toUpperCase()
                                          : "",
                                      style: tstyle(
                                          // color: black,
                                          context: context,
                                          size: 40,
                                          fw: FontWeight.bold),
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          businessl.name.isNotEmpty
                                              ? "${businessl.name[0].toUpperCase()}${businessl.name.substring(1)}"
                                              : "",
                                              overflow: TextOverflow.ellipsis,
                                          style: tstyle(context: context,
                                              fw: FontWeight.w500, size: 20),
                                        ),
                                        Text(
                                          businessl.email,
                                          overflow: TextOverflow.ellipsis,
                                          style: tstyle(
                                            context: context,
                                              fw: FontWeight.w300, size: 15),
                                        ),
                                        Text(
                                          businessl.address,
                                          style: tstyle(
                                            context: context,
                                              fw: FontWeight.w600, size: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: grey.withOpacity(0.8)))),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color:primary,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<BuisnessBloc>()
                                            .add(DeleteBuisness(index));
                                      },
                                    ),
                                  )
                                ]),
                          ),
                          Divider(
                            color: greyLight,
                          )
                        ],
                      );
                    })
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image:
                                const AssetImage('assets/images/business.png'),
                            height: hieght * 0.4,
                          ),
                          if (!isModal)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "No Business!",
                                    style:
                                        tstyle(size: 25,context: context, fw: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          if (!isModal)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Please tap on the plus (+) button bellow to create a business.",
                                style: tstyle(
                                  context: context,
                                  size: 20,
                                  // color: grey.withOpacity(0.8),
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
        // margin: const EdgeInsets.symmetric(vertical: 15),
        height: isModal ? 50 : 50,
        width: isModal ? 50 : 50,
        child: FloatingActionButton(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(50), // Customize the border radius here
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const BusinessInfo();
            }));
          },
          child: Icon(
            Icons.add,
            color: white,
            size: 30,
          ), // Customize the button color here
        ),
      ),
      floatingActionButtonLocation: !isModal
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
