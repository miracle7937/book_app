import 'package:get_time_ago/get_time_ago.dart';
import 'package:lovebook/utils/string_helper.dart';

class ConstantString {
  static final userDataKey = "UserData";
  static final loginData = "loginData";
  static final themeData = "themeData";
  static final enableBiometric = "enableBiometric";
  static final credential = "credential";

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  String getDateTime(String? date) {
    if (isEmpty(date)) {
      return "N/A";
    }
    DateTime targetDate = DateTime.parse(date!);
    return GetTimeAgo.parse(targetDate, locale: 'us');
  }
}
