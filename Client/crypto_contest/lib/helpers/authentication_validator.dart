class AuthenticationValidator {
  String validateEmailValue(String value) {
    if (value.trim().isEmpty) {
      return "Email required";
    }
    if (!value.contains("@")) {
      return "Invalid email address";
    }
    return null;
  }

  String validatePasswordValue(String value) {
    if (value.length < 8) {
      return "Minimum 8 characters are required";
    }
    return null;
  }

  String validateDisplayNameValue(String value) {
    if (value.isEmpty) {
      return "Name required";
    }
    return null;
  }
}
