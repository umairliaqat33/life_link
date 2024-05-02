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

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Business name required";
    } else {
      return null;
    }
  }

  static String? addressValidator(String? value) {
    if (value!.isEmpty) {
      return "Address is required";
    } else {
      return null;
    }
  }

  static String? diseaseValidator(String? value) {
    if (value!.isEmpty) {
      return "Disease is required";
    } else {
      return null;
    }
  }

  static String? ageValidator(String? value) {
    if (value!.isEmpty) {
      return "Age is required";
    } else if (int.parse(value.toString()) < 18) {
      return "Age must be higher then 18";
    } else {
      return null;
    }
  }

  static String? cnicValidator(String? value) {
    if (value!.isEmpty) {
      return "CNIC is required";
    } else if (value.length < 13 || value.length > 13) {
      return "CNIC must be of 13 digits";
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
      return "Message is required";
    } else {
      return null;
    }
  }

  static String? educationValidator(String? value) {
    if (value!.isEmpty) {
      return "Education is required";
    } else {
      return null;
    }
  }

  static String? ambulanceRegistrationNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "Ambulance registration number is required";
    } else {
      return null;
    }
  }

  static String? specialityValidator(String? value) {
    if (value!.isEmpty) {
      return "Speciality is required";
    } else {
      return null;
    }
  }

  static String? licenseNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "License number is required";
    } else {
      return null;
    }
  }
}
