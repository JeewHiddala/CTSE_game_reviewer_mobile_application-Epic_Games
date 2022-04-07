class Validator {
  static String? validateField({required String value}) {

    if (value == null || value.isEmpty) {
      return 'This field cannot be empty. Please enter some value';
    }
    return null;
  }


  static String? validateUserId({required String uid}) {
    if (uid.isEmpty) {
      return 'User ID cannot be empty';
    } else if (uid.length <= 5) {
      return 'User ID should be greater than 5 characters';
    }
  }

}
