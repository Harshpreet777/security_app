import 'package:firebase_demo3/core/constants/string_constants.dart';

class Validations {
  static String? isNameValid(String name) {
    String namePattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(namePattern);
    if (name.toString().isEmpty) {
      return "Cannot be Empty";
    } else if (name.length < 4) {
      return "Minimum 4 Characters";
    } else if (!regExp.hasMatch(name)) {
      return "Only Characters are allowed";
    }
    return null;
  }

  static String? isEmailValid(String email) {
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailPattern);
    if (email.toString().isEmpty) {
      return "Cannot be Empty";
    } else if (!regExp.hasMatch(email)) {
      return "Email is Not Valid";
    }
    return null;
  }
static String? isPassValid(String pass) {
     RegExp regExp = RegExp(StringConstants.passPattern);
    if (pass.toString().isEmpty) {
      return StringConstants.isValidEmpty;
    } else if (!regExp.hasMatch(pass)) {
      return StringConstants.passValid;
    }
    return null;
  }
  static String? isPhoneNoValid(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Cannot be Empty';
    } else if (!regExp.hasMatch(value)) {
      return 'Phone Number is Not Valid';
    }
    return null;
  }
}
