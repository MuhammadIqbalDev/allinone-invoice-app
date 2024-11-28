import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:invoice_app/Constants/colors.dart';
// import '../blocs/bloc_exports.dart';
import '../constants/colors.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

// import '../models/entry.dart';

ButtonStyle buttonStyle(
  BuildContext context, {
  Color? color,
  Size? size,
}) =>
    ElevatedButton.styleFrom(
      backgroundColor: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      disabledBackgroundColor: color?.withOpacity(0.75),
      fixedSize: size ?? Size(MediaQuery.of(context).size.width * 0.32, 40),
    );

ButtonStyle elevatedbuttonStyle(BuildContext context, bool isTapped) {
  return ElevatedButton.styleFrom(
    foregroundColor: whiteColor,
    disabledBackgroundColor: whiteColor,
    disabledForegroundColor: whiteColor,
    elevation: 0,
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: isTapped ? whiteColor : redDarkColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: isTapped
          ? BorderSide(
              color: redDarkColor.withAlpha(150),
              width: 2,
            )
          : BorderSide.none,
    ),
    fixedSize: Size(
      MediaQuery.of(context).size.width * 0.6,
      MediaQuery.of(context).size.width * 0.11,
    ),
  );
}

InputDecoration inputDecoration(
  BuildContext context, {
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? prefixText,
  BorderRadius? borderRadius,
}) {
  // bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      borderSide: BorderSide(color: blackColor, width: 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      borderSide: const BorderSide(color: blackColor, width: 0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      borderSide: const BorderSide(color: redColor, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      borderSide: const BorderSide(color: redColor, width: 1),
    ),
    errorStyle: textStyle(
      fontWeight: FontWeight.w700,
      color: redColor,
      size: 11,
    ),
    filled: true,
    counterText: "",
    isDense: true,
    fillColor:blackColor,
    hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
    prefixIcon: prefixIcon,
    suffixIconConstraints: BoxConstraints.tight(const Size(40, 40)),
    suffixIcon: suffixIcon,
    prefixIconConstraints: BoxConstraints.tight(const Size(40, 40)),
    hintStyle: textStyle(
      fontWeight: FontWeight.w600,
      color: blackColor.withAlpha(150),
      size: 14,
    ),
  );
}

// dynamic viewProvider({
//   required String view,
//   required dynamic forBook,
//   required dynamic forTask,
//   dynamic forExpense,
// }) {
//   switch (view) {
//     case "book":
//       return forBook;
//     case "task":
//       return forTask;
//     case "expense":
//       return Container();
//     default:
//       return Container();
//   }
// }

// Color statusColors(TaskStatus status) {
//   switch (status) {
//     case TaskStatus.pending:
//       return Colors.grey[600]!;
//     case TaskStatus.ongoing:
//       return const Color.fromARGB(255, 238, 181, 11);
//     case TaskStatus.dispute:
//       return redColor;
//     case TaskStatus.done:
//       return greenColor;
//     default:
//       return blackColor;
//   }
// }

TextStyle textStyle({
  double? size,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  Color? color,
  double? letterSpacing,
}) =>
    GoogleFonts.poppins(
      fontSize: size,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      letterSpacing: letterSpacing,
    );

Icon showIcon(IconData icon, bool isDark, double? size) {
  return Icon(
    icon,
    color: isDark ? whiteColor : greyColor,
    size: size,
  );
}

String injectCommas(String text) {
  return NumberFormat("##,##,###").format(int.parse(text));
}

// int getTotalBalance(List<Entry> allEntries) {
//   List<int> allEntriesAmounts = [];
//   for (var entry in allEntries) {
//     if (entry.entryType == EntryType.cashIn) {
//       allEntriesAmounts.add(entry.amount);
//     } else if (entry.entryType == EntryType.cashOut) {
//       allEntriesAmounts.add(-(entry.amount));
//     }
//   }
//   return allEntriesAmounts.sum;
// }

// int getReqSum(List<Entry> allEntries, EntryType entrytype,
//     {bool balance = false,
//     required DateTime time1,
//     required DateTime time2,
//     bool isDay = false,
//     bool isMonth = false,
//     bool isYear = false,
//     bool isRange = false}) {
//   List<int> allEntriesAmounts = [];
//   List<int> allEntriesCashInAmounts = [];
//   if (!balance) {
//     if (isRange) {
//       for (var entry in allEntries.where((entry) =>
//           (entry.entryType == entrytype) &&
//           ((entry.datetime.isAfter(time1) &&
//               entry.datetime.isBefore(time2))))) {
//         allEntriesCashInAmounts.add(entry.amount);
//       }
//     } else if (isDay) {
//       for (var entry in allEntries.where((entry) =>
//           (entry.entryType == entrytype) &&
//           (returnDateTimeCom(entry.datetime, time1)))) {
//         allEntriesCashInAmounts.add(entry.amount);
     
//       }
//     } else if (isMonth) {
//       for (var entry in allEntries.where((entry) =>
//           (entry.entryType == entrytype) &&
//           (entry.datetime.month == time1.month &&
//               entry.datetime.year == time1.year))) {
//         allEntriesCashInAmounts.add(entry.amount);
//       }
//     } else if (isYear) {
//       for (var entry in allEntries.where((entry) =>
//           (entry.entryType == entrytype) &&
//           (entry.datetime.year == time1.year))) {
//         allEntriesCashInAmounts.add(entry.amount);
       
//       }
//     }
//   } else {
//     if (isDay) {
//       for (var entry in allEntries) {
//         if (entry.entryType == EntryType.cashIn &&
//             (returnDateTimeCom(entry.datetime, time1))) {
//           allEntriesAmounts.add(entry.amount);
//         } else if (entry.entryType == EntryType.cashOut) {
//           allEntriesAmounts.add(-(entry.amount));
//         }
//       }
//     }
//     if (isMonth) {
//       for (var entry in allEntries) {
//         if (entry.entryType == EntryType.cashIn) {
//           allEntriesAmounts.add(entry.amount);
//         } else if (entry.entryType == EntryType.cashOut &&
//             (entry.datetime.month == time1.month &&
//                 entry.datetime.year == time1.year)) {
//           allEntriesAmounts.add(-(entry.amount));
//         }
//       }
//     }
//     if (isYear) {
//       for (var entry in allEntries) {
//         if (entry.entryType == EntryType.cashIn) {
//           allEntriesAmounts.add(entry.amount);
//         } else if (entry.entryType == EntryType.cashOut &&
//             (entry.datetime.year == time1.year)) {
//           allEntriesAmounts.add(-(entry.amount));
//         }
//       }
//     }
//     if (isRange) {
//       for (var entry in allEntries) {
//         if (entry.entryType == EntryType.cashIn) {
//           allEntriesAmounts.add(entry.amount);
//         } else if (entry.entryType == EntryType.cashOut &&
//             ((entry.datetime.isAfter(time1) &&
//                 entry.datetime.isBefore(time2)))) {
//           allEntriesAmounts.add(-(entry.amount));
//         }
//       }
//     }
//   }

//   return balance ? allEntriesAmounts.sum : allEntriesCashInAmounts.sum;
// }

// bool returnDateTimeCom(DateTime t1, DateTime t2) {
//   return (t1.month == t2.month && t1.year == t2.year && t1.day == t2.day);
// }

// int getTotalCashIn(
//   List<Entry> allEntries,
// ) {
//   List<int> allEntriesCashInAmounts = [];
//   for (var entry
//       in allEntries.where((entry) => entry.entryType == EntryType.cashIn)) {
//     allEntriesCashInAmounts.add(entry.amount);
//   }
//   return allEntriesCashInAmounts.sum;
// }

// int getTotalCashOut(List<Entry> allEntries) {
//   List<int> allEntriesAmounts = [];
//   for (var entry
//       in allEntries.where((entry) => entry.entryType == EntryType.cashOut)) {
//     allEntriesAmounts.add(entry.amount);
//   }
//   return allEntriesAmounts.sum;
// }

String nameFormater(String name) {
  var pieces = name.trim().split(" ");
  var correctPieces = [];
  if (pieces.length > 1) {
    for (var piece in pieces) {
      correctPieces.add("${piece[0].toUpperCase()}${piece.substring(1)}");
    }
  } else {
    correctPieces.add("${name[0].toUpperCase()}${name.substring(1)}");
  }
  return correctPieces.join(" ");
}

void globalValuesRemover() {
  nameGlobal = null;
  birthDateGlobal = null;
  genderGlobal = null;
  categoryGlobal = null;
  countryGlobal = null;
  phoneGlobal = null;
  emailGlobal = null;
  passwordGlobal = null;
  repeatPasswordGlobal = null;
  allowSyncGlobal = null;
  allowPromotionalTextsGlobal = null;
  keepLoggedInGlobal = null;
}

Future<bool> sendTempPasswordEmail({
  required String name,
  required String email,
  required String tempPass,
}) async {
  const serviceId = 'service_onn3u8d';
  const templateId = 'template_owce2rh';
  const userId = 'A2ZomZe3knYPSHunS';

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': "application/json",
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'name': name,
        'email': email,
        'temp_password': tempPass,
      },
    }),
  );
  return response.statusCode == 200;
}

// Color priorityColors(TaskPriority priority) {
//   switch (priority) {
//     case TaskPriority.high:
//       return redColor;
//     case TaskPriority.medium:
//       return Colors.orange[600]!;
//     case TaskPriority.low:
//       return greenColor;
//     default:
//       return blackColor;
//   }
// }

String getDurationInTwoDigits(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

String getElapsedTime(DateTime datetime) {
  final now = DateTime.now();
  final difference = now.difference(datetime);
  if (difference.inDays > 0) {
    if (difference.inDays == 1) {
      return "${difference.inDays} day ago";
    }
    return "${difference.inDays} days ago";
  } else if (difference.inHours > 0) {
    if (difference.inHours == 1) {
      return "${difference.inHours} hr ago";
    }
    return "${difference.inHours} hrs ago";
  } else if (difference.inMinutes > 0) {
    if (difference.inMinutes == 1) {
      return "${difference.inMinutes} min ago";
    }
    return "${difference.inMinutes} mins ago";
  } else {
    return "Just now";
  }
}
