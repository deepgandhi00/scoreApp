class Validations {
  static validateNonEmptyField(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  static validateNameFields({required String value,
    required String fieldName,}) {
    RegExp exp = RegExp(r"^[-A-Za-z0-9 '‘’]+$");
    if (value.isEmpty) {
      return 'Please enter $fieldName';
    } else if (value.length > 40) {
      return '$fieldName cannot be more than 40 characters';
    } else if (!exp.hasMatch(value)) {
      return 'Please enter valid $fieldName';
    } else {
      return null;
    }
  }
}
