class EmailAlreadyExistException implements Exception {
  final String message;

  EmailAlreadyExistException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);
}

class IncorrectPasswordOrUserNotFound implements Exception {
  final String message;

  IncorrectPasswordOrUserNotFound(this.message);
}

class FormatParsingException implements Exception {
  final String message;

  FormatParsingException(this.message);
}

class StoragePermissionDenied implements Exception {
  final String message;

  StoragePermissionDenied(this.message);
}

class StoragePermissionDeniedPermanently implements Exception {
  final String message;

  StoragePermissionDeniedPermanently(this.message);
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);
}
