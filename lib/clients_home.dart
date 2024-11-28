// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_app/blocs/bloc/client_bloc.dart';
import 'package:invoice_app/model/clientModel.dart';
import 'package:invoice_app/newClient.dart';

import 'Constants/colors.dart';
import 'Widgets/my_widgets/my_drawer.dart';
import 'blocs/theme_switch_bloc/theme_switch_bloc.dart';
import 'invoice_home.dart';

class ClientsHome extends StatefulWidget {
  final bool? isModal;
  const ClientsHome({
    Key? key,
    this.isModal,
  }) : super(key: key);

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  bool isModal = false;
  @override
  void initState() {
    isModal = widget.isModal ?? false;
    // TODO: implement initState
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
              'Clients',
              style: tstyle(size: 25, context: context, fw: FontWeight.bold),
            ),
          ),
          drawer: !isModal ? MyDrawer(existingCxt: context) : null,
          body: BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: state.clientList.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.clientList.length,
                      itemBuilder: (context, index) {
                        ClientModel client = state.clientList[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                if (isModal) {
                                  context
                                      .read<ClientBloc>()
                                      .add(selectedClient(Sc: client));
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return newClient(
                                      EditingClient: client,
                                    );
                                  }));
                                }
                              },
                              child: 
                              client.clientName.isNotEmpty? Row(
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
                                      client.clientName[0].toUpperCase(),
                                      style: tstyle(
                                          context: context,
                                          color: black,
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
                                          "${client.clientName[0].toUpperCase()}${client.clientName.substring(1)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: tstyle(
                                              context: context,
                                              fw: FontWeight.w500,
                                              size: 20),
                                        ),
                                        Text(
                                          client.clientEmail,
                                          overflow: TextOverflow.ellipsis,
                                          style: tstyle(
                                              context: context,
                                              fw: FontWeight.w300,
                                              size: 15),
                                        ),
                                        Text(
                                          client.clientPhone,
                                          style: tstyle(
                                              context: context,
                                              fw: FontWeight.w600,
                                              size: 14),
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
                                      color: !isDark ? blackColor : whiteColor,
                                    ))),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: primary,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<ClientBloc>()
                                            .add(DeleteClient(index));
                                      },
                                    ),
                                  )
                                ],
                              ): const SizedBox()
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
                                  const AssetImage('assets/images/clients.png'),
                              height: hieght * 0.4,
                            ),
                            if (!isModal)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "No clients!",
                                      style: tstyle(
                                          size: 25,
                                          context: context,
                                          color:
                                              !isDark ? blackColor : whiteColor,
                                          fw: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            if (!isModal)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Please tap on the plus (+) button bellow to create a client.",
                                  style: tstyle(
                                    color: !isDark ? blackColor : whiteColor,
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
                    ),
              // SizedBox()
            );
          }),
          floatingActionButton: SizedBox(
            // margin: const EdgeInsets.symmetric(vertical: 15),
            height: isModal ? 50 : 50,
            width: isModal ? 50 : 50,
            child: FloatingActionButton(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Customize the border radius here
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const newClient();
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
      },
    );
  }
}
