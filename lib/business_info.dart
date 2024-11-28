// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:invoice_app/Constants/colors.dart';
import 'package:invoice_app/Widgets/textFormFieldWidget.dart';
import 'package:invoice_app/blocs/bloc/buisness_bloc.dart';
import 'package:invoice_app/model/businessInfo.dart';

import 'helpers/id_generator.dart';
import 'invoice_home.dart';

class BusinessInfo extends StatefulWidget {
  final Business_Info? EditingBusiness;
  const BusinessInfo({
    Key? key,
    this.EditingBusiness,
  }) : super(key: key);

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
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

  String? _nameError;
  String? _addressError;
  String? _phoneError;
  String? _emailError;

  @override
  void initState() {
    if (widget.EditingBusiness != null) {
      _textFieldNameController.text = widget.EditingBusiness!.name;
      _textFieldAddressController.text = widget.EditingBusiness!.address;
      _textFieldPhoneController.text = widget.EditingBusiness!.phone.toString();
      _textFieldEmailController.text = widget.EditingBusiness!.email;
    }
    super.initState();
  }

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

  void _proceedToNextScreen() {
    setState(() {
      _nameError = _textFieldNameController.text.isEmpty
          ? 'Please fill in name field'
          : null;
      _addressError = _textFieldAddressController.text.isEmpty
          ? 'Please fill in address field'
          : null;
      _phoneError = _textFieldPhoneController.text.isEmpty
          ? 'Please fill in phone field'
          : null;
      _emailError = _textFieldEmailController.text.isEmpty
          ? 'Please fill in email field'
          : null;
    });

    // if (_nameError == null &&
    //     _addressError == null &&
    //     _phoneError == null &&
    //     _emailError == null) {
    //   Business_Info binfo = Business_Info(
    //     widget.EditingBusiness!=null? widget.EditingBusiness!.business_id:
    //       name: _textFieldNameController.text,
    //       address: _textFieldAddressController.text,
    //       image: null,
    //       email: _textFieldEmailController.text);
    //   context.read<BuisnessBloc>().add(AddBuisness(buisness: binfo));
    //   context.read<BuisnessBloc>().add(selectedBuisness(sb: binfo));
    // Navigator.of(context).pop();
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => NewInvoice(
    //       binfo: binfo,
    //     ),
    //   ),
    // );
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double hieght = MediaQuery.sizeOf(context).width;
    return BlocBuilder<BuisnessBloc, BuisnessState>(builder: (context, bstate) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Bussiness Info',
            style: tstyle(size: 20, context: context, fw: FontWeight.w600),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  // _proceedToNextScreen();

                  if (!_formKey.currentState!.validate()) {
                    log('validation are working');
                  } else {
                    {
                      Business_Info binfo = Business_Info(
                          widget.EditingBusiness != null
                              ? widget.EditingBusiness!.business_id
                              : bstate.businessList.length + 1,
                          _textFieldNameController.text,
                          _textFieldAddressController.text,
                          int.tryParse(_textFieldPhoneController.text),
                          null,
                          _textFieldEmailController.text);

                      if (widget.EditingBusiness != null) {
                        context
                            .read<BuisnessBloc>()
                            .add(EditBusiness(editBusiness: binfo));
                      } else {
                        context
                            .read<BuisnessBloc>()
                            .add(AddBuisness(buisness: binfo));
                        context
                            .read<BuisnessBloc>()
                            .add(selectedBuisness(sb: binfo));
                      }
                      // Navigator.of(context).pop();
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => NewInvoice(
                      //       binfo: binfo,
                      //     ),
                      //   ),
                      // );
                      Navigator.of(context).pop();
                    }
                    log('${bstate.businessList}');
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: InkWell(
                      onTap: () => _getImageFromGallery(true),
                      child: imageUrl == null
                          ? DottedBorder(
                              color: grey.withOpacity(0.4),
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(20),
                              dashPattern: const [10, 10],
                              strokeWidth: 1,
                              child: SizedBox(
                                width: width * 0.3,
                                height: width * 0.3,
                                child: Center(
                                  child: logoReady == true
                                      ? Text(
                                          'LOGO',
                                          style: tstyle(
                                            context: context,
                                            size: 16,
                                            fw: FontWeight.w400,
                                            color: grey,
                                          ),
                                        )
                                      : const CircularProgressIndicator(
                                          color: greenColor,
                                        ),
                                ),
                              ),
                            )
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
                    child: SizedBox(
                        width: 300,
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
                          // cursorColor: AppColors.PrimaryColor,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: CustomTextFormField(
                        controller: _textFieldAddressController,
                        labelText: "Address",
                        // cursorColor: AppColors.PrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 300,
                        child: CustomTextFormField(
                          // cursorColor: AppColors.PrimaryColor,
                          controller: _textFieldPhoneController,
                          labelText: "Phone",
                          keyboardType: TextInputType.number,
                          
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 300,
                        child: CustomTextFormField(
                          controller: _textFieldEmailController,
                          labelText: "Email",
                         
                          // cursorColor: AppColors.PrimaryColor,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
