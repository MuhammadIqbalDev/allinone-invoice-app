import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_app/helpers/id_generator.dart';
import 'package:invoice_app/helpers/methods.dart';
import 'package:invoice_app/services/database_exceptions.dart';

import '../model/user.dart';

class FirebaseService {
  FirebaseService._sharedInstance();
  static final FirebaseService _shared = FirebaseService._sharedInstance();
  factory FirebaseService() => _shared;

  // final NotificationService notificationService = NotificationService();

  // final booksCollectionRef =
  //     FirebaseFirestore.instance.collection(booksCollection);
  // final invitationsCollectionRef =
  //     FirebaseFirestore.instance.collection(invitationsCollection);
  // final tasksCollectionRef =
  //     FirebaseFirestore.instance.collection(tasksCollection);
  final usersCollectionRef =
      FirebaseFirestore.instance.collection(usersCollection);

  final imagesRef = FirebaseStorage.instance.ref("images");
  final voicesRef = FirebaseStorage.instance.ref("voices");
  // AUTH

  Future<User> registerUser({required User user}) async {
    final checkingWithEmail = await usersCollectionRef
        .where('email', isEqualTo: user.email.toLowerCase())
        .get();
    if (checkingWithEmail.docs.isNotEmpty) {
      throw UserAlreadyExists();
    }
    final checkingWithPhone =
        await usersCollectionRef.where('phone', isEqualTo: user.phone).get();
    if (checkingWithPhone.docs.isNotEmpty) {
      throw UserAlreadyExists();
    }
    final createdUserRef = await usersCollectionRef.add(user.toMap());
    final createdUserSnapshot = await createdUserRef.get();
    final createdUser = User.fromMap(createdUserSnapshot.data()!);

    // await FirebaseMessaging.instance.getToken().then((token) {
    //   if (token != null) {
    //     usersCollectionRef.doc(createdUserRef.id).update({
    //       'token': token,
    //     });
    //   }
    // });

    return createdUser;
  }

  Future<User> loginUser({
    String? email,
    int? phone,
    required String password,
  }) async {
    User? user;
    if (email == null && phone != null) {
      log("Before finded user---------------: $user");
      final findedUser =
          await usersCollectionRef.where('phone', isEqualTo: phone).get();

      if (findedUser.docs.isNotEmpty) {
        user = findedUser.docs.map((doc) => User.fromMap(doc.data())).single;
      }
    } else if (email != null && phone == null) {
      final findedUser = await usersCollectionRef
          .where('email', isEqualTo: email.toLowerCase())
          .get();
      if (findedUser.docs.isNotEmpty) {
        user = findedUser.docs.map((doc) => User.fromMap(doc.data())).single;
      }
    }
    log("finded user---------------: $user");
    if (user == null) {
      throw UserNotFound();
    } else if (password != user.password) {
      if (user.temporaryPassword != null) {
        final isExpired = DateTime.now()
                .difference(user.temporaryPasswordDateTime!)
                .inHours >=
            1;
        if (password != user.temporaryPassword) {
          throw WrongPassword();
        } else if (password == user.temporaryPassword && isExpired) {
          throw TemporaryPasswordExpired();
        }
      } else {
        throw WrongPassword();
      }
    }
    log("token estarted-------");
    try {
      // await FirebaseMessaging.instance.getToken().then((token) async {
      //   if (token != null) {
      //     log(token);
      //     await usersCollectionRef
      //         .where('email', isEqualTo: user!.email)
      //         .get()
      //         .then((query) {
      //       var docss = usersCollectionRef.doc(query.docs.single.id);

      //       docss.update({
      //         'token': token,
      //       });

      //     });
      //   }
      // });
    } catch (e) {
      log(e.toString());
    }

    log("token ended");

    return user;
  }

  Future<bool> forgotPassword({required String email}) async {
    final findedUser = await usersCollectionRef
        .where('email', isEqualTo: email.toLowerCase())
        .get();
    if (findedUser.docs.isEmpty) {
      throw UserNotFound();
    } else {
      final userDoc = findedUser.docs.single;
      final user = User.fromMap(userDoc.data());
      final tempPass = tempPassGenerator().toUpperCase();
      usersCollectionRef.doc(userDoc.id).set(user
          .copyWith(
            temporaryPassword: tempPass,
            temporaryPasswordDateTime: DateTime.now(),
          )
          .toMap());

      final emailSent = await sendTempPasswordEmail(
        name: user.name,
        email: email,
        tempPass: tempPass,
      );
      if (emailSent) {
        return emailSent;
      } else {
        throw GenericAuthException();
      }
    }
  }

  Future<User> updateUser({
    required User user,
    String? name,
    String? email,
    String? country,
    int? phone,
    String? password,
  }) async {
    final querySnapshot = await usersCollectionRef
        .where(
          'email',
          isEqualTo: user.email,
        )
        .get();

    final doc = querySnapshot.docs.single;

    final updatedUser = user.copyWith(
      name: name ?? user.name,
      email: email ?? user.email,
      country: country ?? user.country,
      phone: phone ?? user.phone,
      password: password ?? user.password,
    );

    usersCollectionRef.doc(doc.id).set(updatedUser.toMap());

    return updatedUser;
  }

  // OTHERS

  Future<String?> getToken(
      {required String country, required int phone}) async {
    final querySnapshot = await usersCollectionRef
        .where('country', isEqualTo: country)
        .where('phone', isEqualTo: phone)
        .get();
    if (querySnapshot.docs.isEmpty) {
      throw UserNotFound();
    }
    String? userToken = querySnapshot.docs.single.data()['token'];

    return userToken;
  }

//   Future<Member> getMemberByNumber(
//       {required String country, required int phone}) async {
//     final querySnapshot = await usersCollectionRef
//         .where('country', isEqualTo: country)
//         .where('phone', isEqualTo: phone)
//         .get();
//     if (querySnapshot.docs.isEmpty) {
//       throw UserNotFound();
//     }
//     final user = User.fromMap(querySnapshot.docs.single.data());
//     return Member(
//       name: user.name,
//       phone: user.phone,
//       country: Country.parse(user.country),
//     );
  }


// const booksCollection = 'books';
// const invitationsCollection = 'invitations';
// const tasksCollection = 'tasks';
const usersCollection = 'users';

