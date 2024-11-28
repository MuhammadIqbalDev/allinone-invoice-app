import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/addnewInvoice.dart';
import '../model/businessInfo.dart';
import '../model/clientModel.dart';
import '../model/itemModel.dart';
import '../model/taxModal.dart';

class Local_Storage {
  Local_Storage._sharedInstance();
  static final Local_Storage _shared = Local_Storage._sharedInstance();
  factory Local_Storage() => _shared;

  Future<String> get _localPath async {
    final docsDir = await getApplicationDocumentsDirectory();
    return docsDir.path;
  }

//invoice Details
  Future<File> get _localInvoiceFile async {
    final String path = await _localPath;
    final String filePath = join(path, "invoice_details.json");
    return File(filePath);
  }

  Future<void> deleteInvoiceDetails() async {
    final File file = await _localInvoiceFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    detailsFile.flushSync();
    await detailsFile.close();
  }

  Future<void> saveInvoiceDetails(List<InvoiceModel> map) async {
    final File file = await _localInvoiceFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );

    try {
      await deleteInvoiceDetails();

      log("invoce to save :  $map");

      // Convert the 'business' list back to a map
      Map<String, dynamic> mapToSave = InvoiceModel.convertListToMap(map);

      log("maptoSave : $mapToSave");

      // Convert the map to JSON and write it to the file
      String jsonString = json.encode(map);

      await detailsFile.writeString(jsonString);

      // log("Business details saved successfully!");
    } catch (e) {
      log("Error while saving invoice details: $e");
    } finally {
      await detailsFile.close();
    }
  }

  Future<List<InvoiceModel>?> getInvoiceDetails() async {
    final File file = await _localInvoiceFile;
    if (await file.exists()) {
      String readFile = await file.readAsString();
      if (readFile.isNotEmpty) {
        try {
          // Parse the JSON string to a map
          Map<String, dynamic> details = json.decode(readFile);
          // Convert the dynamic map to the required type Map<String, List<Business_Info>>
          List<InvoiceModel> invoiceMap = details != null
              ? (details['invoice'])
                  .map((InvoiceJson) => InvoiceModel.fromMap(InvoiceJson))
                  .toList()
              : [];

          // log("parsed business details: $invoiceMap");
          return invoiceMap;
        } catch (e) {
          log("Error parsing JSON invoice data : $e");
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

// for Buisness Details......
  Future<File> get _localBusinessFile async {
    final String path = await _localPath;
    final String filePath = join(path, "buisness_details.json");
    return File(filePath);
  }

  Future<void> deleteBusinessDetails() async {
    final File file = await _localBusinessFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    detailsFile.flushSync();
    await detailsFile.close();
  }

  Future<void> saveBusinessDetails(Map<String, List<Business_Info>> map) async {
    final File file = await _localBusinessFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );

    try {
      await deleteBusinessDetails();
      // Convert the 'business' list back to a map
      Map<String, dynamic> mapToSave =
          Business_Info.convertListToMap(map['business']!);

      // log("maptoSave : $mapToSave");

      // Convert the map to JSON and write it to the file
      String jsonString = json.encode(mapToSave);
      await detailsFile.writeString(jsonString);

      // log("Business details saved successfully!");
    } catch (e) {
      log("Error while saving business details: $e");
    } finally {
      await detailsFile.close();
    }
  }

  Future<List<Business_Info>?> getBusinessDetails() async {
    final File file = await _localBusinessFile;
    if (await file.exists()) {
      String readFile = await file.readAsString();
      if (readFile.isNotEmpty) {
        try {
          // Parse the JSON string to a map
          Map<String, dynamic> details = json.decode(readFile);
          // Convert the dynamic map to the required type Map<String, List<Business_Info>>
          List<Business_Info> businessMap = details != null
              ? (details['business'] as List<dynamic>)
                  .map((businessJson) => Business_Info.fromMap(businessJson))
                  .toList()
              : [];

          // log("parsed business details: $businessMap");
          return businessMap;
        } catch (e) {
          log("Error parsing JSON buisnesss data : $e");
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

// for Clients Details....
  Future<File> get _localClientFile async {
    final String path = await _localPath;
    final String filePath = join(path, "clients_details.json");
    return File(filePath);
  }

  Future<void> deleteClientDetails() async {
    final File file = await _localClientFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    detailsFile.flushSync();
    await detailsFile.close();
  }

  Future<void> saveClientDetails(Map<String, dynamic> map) async {
    final File file = await _localClientFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    try {
      await deleteClientDetails();
      // Convert the 'business' list back to a map
      Map<String, dynamic> mapToSave =
          ClientModel.convertListToMap(map['clients']!);

      // log("maptoSave Clients : $mapToSave");

      // Convert the map to JSON and write it to the file
      String jsonString = json.encode(mapToSave);
      await detailsFile.writeString(jsonString);

      // log("Clients details saved successfully!");
    } catch (e) {
      log("Error while saving Clients details: $e");
    } finally {
      await detailsFile.close();
    }
  }

  Future<List<ClientModel>?> getClientDetails() async {
    final File file = await _localClientFile;

    if (await file.exists()) {
      String readFile = await file.readAsString();
      if (readFile.isNotEmpty) {
        try {
          // Parse the JSON string to a map
          Map<String, dynamic> details = json.decode(readFile);
          // log(" All clients :  ${details.toString()}");
          // Convert the dynamic map to the required type Map<String, List<Business_Info>>
          List<ClientModel> clientMap = details != null
              ? (details['clients'] as List<dynamic>)
                  .map((client) => ClientModel.fromMap(client))
                  .toList()
              : [];

          // log("parsed Clients details: $clientMap");
          return clientMap;
        } catch (e) {
          log("Error parsing JSON clients data: $e");
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

// for Items Details......

  Future<File> get _localItemFile async {
    final String path = await _localPath;
    final String filePath = join(path, "items_details.json");
    return File(filePath);
  }

  Future<void> deleteItemDetails() async {
    final File file = await _localItemFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    detailsFile.flushSync();
    await detailsFile.close();
  }

  Future<void> saveItemDetails(List<AddItem> map) async {
    final File file = await _localItemFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    try {
      await deleteItemDetails();
      // Convert the 'business' list back to a map
      Map<String, dynamic> mapToSave = AddItem.convertListToMap(map);

      // log("maptoSave Item : $mapToSave");

      // Convert the map to JSON and write it to the file
      String jsonString = json.encode(mapToSave);
      await detailsFile.writeString(jsonString);

      // log("Item details saved successfully!");
    } catch (e) {
      log("Error while saving Items details: $e");
    } finally {
      await detailsFile.close();
    }
  }

  Future<List<AddItem>?> getItemDetails() async {
    final File file = await _localItemFile;

    if (await file.exists()) {
      String readFile = await file.readAsString();
      if (readFile.isNotEmpty) {
        try {
          // Parse the JSON string to a map
          Map<String, dynamic> details = json.decode(readFile);
          log("Item details : ${details['items']}");

          List<AddItem> itemMap = details != null
              ? (details['items'] as List<dynamic>)
                  .map((item) => AddItem.fromMap(item))
                  .toList()
              : [];

          return itemMap;
        } catch (e) {
          log("Error parsing JSON items details: $e");
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //For Tax
  Future<File> get _localTaxFile async {
    final String path = await _localPath;
    final String filePath = join(path, "Tax_details.json");
    return File(filePath);
  }

  Future<void> deleteTaxDetails() async {
    final File file = await _localTaxFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    detailsFile.flushSync();
    await detailsFile.close();
  }

  Future<void> saveTaxDetails(List<AddTax> map) async {
    final File file = await _localTaxFile;
    final RandomAccessFile detailsFile = await file.open(
      mode: FileMode.writeOnly,
    );
    try {
      await deleteTaxDetails();

      Map<String, dynamic> mapToSave = AddTax.convertListToMap(map);

      log("maptoSave Tax : $mapToSave");
      String jsonString = json.encode(mapToSave);
      await detailsFile.writeString(jsonString);

      log("Tax details saved successfully!");
    } catch (e) {
      log("Error while saving Tax details: $e");
    } finally {
      await detailsFile.close();
    }
  }

  Future<List<AddTax>?> getTaxDetails() async {
    final File file = await _localTaxFile;

    if (await file.exists()) {
      String readFile = await file.readAsString();
      if (readFile.isNotEmpty) {
        try {
          // log("Tax details : before download data");
          // Parse the JSON string to a map
          Map<String, dynamic> details = json.decode(readFile);
          // log("Tax details : $details");
          // var allTax = details['taxes'];
          // log("alltax : $allTax");
          // Convert the dynamic map to the required type Map<String, List<Business_Info>>
          List<AddTax> TaxMap = details != null
              ? (details['taxes'] as List<dynamic>)
                  .map((taxJson) => AddTax.fromMap(taxJson))
                  .toList()
              : [];
          log("parsed tax details: $TaxMap");
          return TaxMap;
        } catch (e) {
          log("Error parsing JSON Tax: $e");
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
