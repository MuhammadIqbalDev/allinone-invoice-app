// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_app/Dialogs/add_item.dart';
import 'package:invoice_app/model/itemModel.dart';

import 'Constants/colors.dart';
import 'Widgets/my_widgets/my_drawer.dart';
import 'blocs/bloc/items_bloc.dart';
import 'invoice_home.dart';
import 'newClient.dart';

class ItemsHome extends StatefulWidget {
  final bool? isModal;
  const ItemsHome({
    Key? key,
    required this.isModal,
  }) : super(key: key);

  @override
  State<ItemsHome> createState() => _ItemsHomeState();
}

class _ItemsHomeState extends State<ItemsHome> {
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
          'Items',
          style: tstyle(size: 25, context: context, fw: FontWeight.bold),
        ),
      ),
      drawer: !isModal ? MyDrawer(existingCxt: context) : null,
      body: BlocBuilder<ItemsBloc, ItemsState>(builder: (context, state) {
        return Container(
            child: state.allItem.isNotEmpty
                ? ListView.builder(
                    itemCount: state.allItem.length,
                    itemBuilder: (context, index) {
                      AddItem item = state.allItem[index];
                      return InkWell(
                        onTap: () async {
                          if (isModal) {
                            log('item in screen of item home 1-----------$item');

                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                            await showModalBottomSheet(
                                context: context,
                                builder: ((context) => NewItem(
                                      isModal: isModal,
                                      item: item,
                                    )));
                          } else {
                            log('item ID----------${item.itemId}');
                            log('item ID----------${item.selected_id}');
                            log('item in screen of item home 2-----------$item');
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return NewItem(
                                  item: item,
                                  isModal: isModal,
                                  EditingItem: item);
                            }));
                          }
                          //  context
                          //     .read<ItemsBloc>()
                          //     .add(SelectedItems(selectedItem: allItems));
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:160,
                                        child: Text(
                                          overflow:TextOverflow.ellipsis,
                                          "${item.itemName[0].toUpperCase()}${item.itemName.substring(1)}",
                                          style: tstyle(
                                              context: context,
                                              fw: FontWeight.w500,
                                              size: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        width:160,
                                        child: Text(
                                          item.description,
                                          // textAlign: TextAlign.end,
                                          overflow:TextOverflow.ellipsis,
                                          style: tstyle(
                                              context: context,
                                              fw: FontWeight.w300,
                                              size: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 73,
                                            child: Text(
                                              "$currency${item.unitPrice}",
                                               overflow: TextOverflow.ellipsis,
                                              style: tstyle(
                                                  context: context,
                                                  fw: FontWeight.w500,
                                                  size: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              item.unit,
                                              style: tstyle(
                                                  context: context,
                                                  fw: FontWeight.w300,
                                                  size: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: grey
                                                        .withOpacity(0.8)))),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: primary,
                                          ),
                                          onPressed: () {
                                            context
                                                .read<ItemsBloc>()
                                                .add(DeleteFromAllItems(item));
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
                        ),
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
                            image: const AssetImage('assets/images/items.png'),
                            height: hieght * 0.3,
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          if (!isModal)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "No Items!",
                                    style: tstyle(
                                        size: 25,
                                        context: context,
                                        fw: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Please tap on the plus (+) button bellow to create an item.",
                                    style: tstyle(
                                      context: context,
                                      size: 20,
                                      color: grey.withOpacity(0.8),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
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
            borderRadius:
                BorderRadius.circular(50), 
          ),
          onPressed: () {
            if (!isModal) {
              // Navigator.of(context).pop();
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const NewItem(
                isModal: false,
                item: null,
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
      floatingActionButtonLocation: !isModal
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
