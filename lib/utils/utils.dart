import 'package:life_link/constants/constants.dart';

class Utils {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email required";
    } else if (!RegExp(emailPatter).hasMatch(value)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password required";
    } else if (value.length < 8) {
      return "Minimum 8 character required in password";
    } else {
      return null;
    }
  }

  static String? businessNameValidator(String? value) {
    if (value!.isEmpty) {
      return "Business name required";
    } else {
      return null;
    }
  }

  static String? simpleValidator(String? value) {
    if (value!.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? quantityValidator(String? value) {
    if (value!.isEmpty) {
      return "i.e. 1 or 2";
    } else if (int.parse(value) <= 0) {
      return "i.e. 1 or 2";
    } else {
      return null;
    }
  }

  static String? salePriceValidator(String? value) {
    if (value!.isEmpty) {
      return "Please add sale price";
    } else if (int.parse(value.toString()) <= 0) {
      return "Sale price must be more then 0";
    } else {
      return null;
    }
  }

  static String? purchasePriceValidator(String? value) {
    if (value!.isEmpty) {
      return "Please add purchase price";
    } else if (int.parse(value.toString()) <= 0) {
      return "Purchase price must be more then 0";
    } else {
      return null;
    }
  }

  static String? subjectValidator(String? value) {
    if (value!.isEmpty) {
      return "Subject is required";
    } else {
      return null;
    }
  }

  static String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone number required";
    }
    if (!RegExp(phoneNumberPattern).hasMatch(value)) {
      return "Enter a valid phone";
    }
    return null;
  }

  static String? messageValidator(String? value) {
    if (value!.isEmpty) {
      return "message is required";
    } else {
      return null;
    }
  }
}
