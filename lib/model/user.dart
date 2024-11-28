// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';

// Global Values
String? nameGlobal;
DateTime? birthDateGlobal;
Gender? genderGlobal;
Category? categoryGlobal;
int? phoneGlobal;
Country? countryGlobal = Country.parse("PK");
String? emailGlobal;
String? passwordGlobal;
String? repeatPasswordGlobal;
bool? allowSyncGlobal;
bool? allowPromotionalTextsGlobal;
bool? keepLoggedInGlobal;

// Table Field Names
const nameColumn = "name";
const dateOfBirthColumn = "birth_date";
const genderColumn = "gender";
const categoryColumn = "category";
const countryColumn = "country";
const phoneColumn = "phone";
const emailColumn = "email";
const passwordColumn = "password";
const temporaryPasswordColumn = "temporary_password";
const temporaryPasswordDateTimeColumn = "temporary_password_datetime";
const allowSyncColumn = "allow_sync";
const allowPromotionalTextsColumn = "allow_promotional_texts";

enum Gender { male, female }

enum Category {
  student,
  freelancer,
  employee,
  businessman,
  unemployed,
  retired,
}

@immutable
class User {
  final String name;
  final DateTime dateOfBirth;
  final Gender gender;
  final Category category;
  final String country;
  final int phone;
  final String email;
  final String password;
  final String? temporaryPassword;
  final DateTime? temporaryPasswordDateTime;
  final bool allowSync;
  final bool allowPromotionalTexts;

  const User({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.category,
    required this.phone,
    required this.country,
    required this.email,
    this.temporaryPassword,
    this.temporaryPasswordDateTime,
    required this.password,
    required this.allowSync,
    required this.allowPromotionalTexts,
  });

  Map<String, dynamic> toMap() {
    return {
      nameColumn: name,
      dateOfBirthColumn: dateOfBirth.toIso8601String(),
      genderColumn: gender.name,
      categoryColumn: category.name,
      countryColumn: country,
      phoneColumn: phone,
      emailColumn: email,
      temporaryPasswordColumn: temporaryPassword,
      temporaryPasswordDateTimeColumn:
          temporaryPasswordDateTime?.toIso8601String(),
      passwordColumn: password,
      allowSyncColumn: allowSync ? 1 : 0,
      allowPromotionalTextsColumn: allowPromotionalTexts ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map[nameColumn],
      dateOfBirth: DateTime.parse(map[dateOfBirthColumn]),
      gender: Gender.values.byName(map[genderColumn]),
      category: Category.values.byName(map[categoryColumn]),
      country: map[countryColumn],
      phone: map[phoneColumn],
      email: map[emailColumn],
      password: map[passwordColumn],
      temporaryPassword: map[temporaryPasswordColumn],
      temporaryPasswordDateTime:
      map[temporaryPasswordDateTimeColumn]!=null ?    DateTime.tryParse(
            map[temporaryPasswordDateTimeColumn]) ?? DateTime.now() : DateTime.now()
            // )
            ,
      allowSync: map[allowSyncColumn] == 1 ? true : false,
      allowPromotionalTexts:
          map[allowPromotionalTextsColumn] == 1 ? true : false,
    );
  }

  @override
  String toString() =>
      'User(Name: $name, Phone: $phone, Birth Date: $dateOfBirth, Gender: ${gender.name}, Category: ${category.name}, Email: $email, Password: $password, Allow Cloud Backup: $allowSync, Allow Promotional Texts: $allowPromotionalTexts)';

  User copyWith({
    String? name,
    DateTime? dateOfBirth,
    Gender? gender,
    Category? category,
    String? country,
    int? phone,
    String? email,
    String? password,
    String? temporaryPassword,
    DateTime? temporaryPasswordDateTime,
    bool? allowSync,
    bool? allowPromotionalTexts,
  }) {
    return User(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      category: category ?? this.category,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      temporaryPassword: temporaryPassword ?? this.temporaryPassword,
      temporaryPasswordDateTime:
          temporaryPasswordDateTime ?? this.temporaryPasswordDateTime,
      allowSync: allowSync ?? this.allowSync,
      allowPromotionalTexts:
          allowPromotionalTexts ?? this.allowPromotionalTexts,
    );
  }
}
