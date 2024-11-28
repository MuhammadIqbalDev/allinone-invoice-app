import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_app/blocs/bloc/client_bloc.dart';
import 'package:invoice_app/model/clientModel.dart';

import 'Constants/colors.dart';
import 'Widgets/textFormFieldWidget.dart';
import 'helpers/id_generator.dart';
import 'invoice_home.dart';

class newClient extends StatefulWidget {
  final ClientModel? EditingClient;
  const newClient({super.key, this.EditingClient});

  @override
  State<newClient> createState() => _newClientState();
}

class _newClientState extends State<newClient> {
  XFile? _pickedImage;
  String? imageUrl;
  final TextEditingController _textFieldNameController =
      TextEditingController();
  final TextEditingController _textFieldAddressController =
      TextEditingController();
  final TextEditingController _textFieldPhoneController =
      TextEditingController();
  final TextEditingController _textFieldEmailController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.EditingClient != null) {
      _textFieldNameController.text = widget.EditingClient!.clientName;
      _textFieldAddressController.text = widget.EditingClient!.clientAddress;
      _textFieldPhoneController.text = widget.EditingClient!.clientPhone;
      _textFieldEmailController.text = widget.EditingClient!.clientEmail;
    }
    super.initState();
  }

  String? _nameError;
  String? _addressError;
  String? _phoneError;
  String? _emailError;

  // Future<void> _getImageFromGallery() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _pickedImage = pickedImage;
  //   });
  // }
  bool logoReady = true;
  bool? imageready;
  @override
  void dispose() {
    _textFieldNameController.dispose();
    _textFieldAddressController.dispose();
    _textFieldEmailController.dispose();
    _textFieldPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double hieght = MediaQuery.sizeOf(context).width;
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, cstate) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Add new client',
              style: tstyle(size: 20, context: context, fw: FontWeight.w600),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      log('validation are working');
                    } else {
                      ClientModel createdClient = ClientModel(
                          widget.EditingClient != null
                              ? widget.EditingClient!.client_id
                              : cstate.clientList.length + 1,
                          _textFieldNameController.text,
                          _textFieldAddressController.text,
                          _textFieldPhoneController.text,
                          _textFieldEmailController.text);
                      if (widget.EditingClient != null) {
                        context
                            .read<ClientBloc>()
                            .add(EditClient(editclient: createdClient));
                      } else {
                        context
                            .read<ClientBloc>()
                            .add(AddClient(client: createdClient));
                        context
                            .read<ClientBloc>()
                            .add(selectedClient(Sc: createdClient));
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "SAVE",
                    style: tstyle(
                      context: context,
                      size: 16,
                      fw: FontWeight.w400,
                      // color: grey,
                    ),
                  ))
            ],
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: InkWell(
                        onTap: () => _getImageFromGallery(false),
                        child: imageUrl == null
                            ? DottedBorder(
                                color: grey.withOpacity(0.4),
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                dashPattern: const [10, 10],
                                strokeWidth: 1,
                                child: logoReady == true
                                    ? Container(
                                        width: width * 0.3,
                                        height: width * 0.3,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/profile.png'))),
                                      )
                                    : const CircularProgressIndicator(
                                        color: greenColor,
                                      ))
                            : SizedBox(
                                width: width * 0.3,
                                height: hieght * 0.3,
                                child: ClipRRect(
                                  child: Image.network(imageUrl!),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: _textFieldNameController,
                        labelText: "Name",
                        // errorText: _nameError,
                        validator: (value) {
                          log('validation yes');
                          if (value == null) {
                            return 'Please enter Name';
                          } else if (value.toString().isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: _textFieldAddressController,
                        labelText: "Address",
                        // errorText: _addressError,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: _textFieldPhoneController,
                        labelText: "Phone",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: _textFieldEmailController,
                        labelText: "Email",
                        errorText: _emailError,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImageFromGallery(bool isbusiness) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    //  _pickedImage = pickedImage;
    log("picked image : $pickedImage");

    setState(() async {
      imageUrl = await _uploadtoStorage(
        File(pickedImage!.path),
        isbusiness: true,
      );
    });
  }

  Future<String?> _uploadtoStorage(File filepath,
      {required bool isbusiness}) async {
    setState(() {
      imageUrl == null;
      logoReady = false;
    });
    Reference root = FirebaseStorage.instance.ref();
    Reference rootChild = root.child('invoice');
    Reference userImage = rootChild.child(
        '${isbusiness ? "business-" : "client-"}${DateTime.now().millisecondsSinceEpoch}-${shortIDGenerator()}');
    try {
      // String tempImage = ImageUrl!;
      log('user image : $userImage');
      await userImage.putFile(File(filepath.path));
      log('upload image : ');
      final tempImageUrl = await userImage.getDownloadURL();

      setState(() {
        logoReady = false;
      });
      log("log : $tempImageUrl");
      return tempImageUrl;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

String currency='Rs';
