import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
    required TextInputAction inputAction,
    required String label,
    required String hint,
    required String initialValue,
    required Function(String value) validator,
    this.isObscure = false,
    this.isCapitalized = false,
    this.maxLines = 1,
    this.isLabelEnabled = true,
    required bool isEnabled,
  }) :
        _keyboardtype = keyboardType,
        _inputAction = inputAction,
        _label = label,
        _hint = hint,
        _initialValue = initialValue,
        _validator = validator,
        _isEnabled = isEnabled,
        super(key: key);

  final TextInputType _keyboardtype;
  final TextInputAction _inputAction;
  final String _label;
  final String _hint;
  final String _initialValue;
  final bool isObscure;
  final bool isCapitalized;
  final int maxLines;
  final bool isLabelEnabled;
  final Function(String) _validator;
  final bool _isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: _initialValue,
      enabled: _isEnabled,
      maxLines: maxLines,
      keyboardType: _keyboardtype,
      obscureText: isObscure,
      textCapitalization:
      isCapitalized ? TextCapitalization.words : TextCapitalization.none,
      textInputAction: _inputAction,
      cursorColor: Colors.yellow,
      validator: (value) => _validator(value!),
      decoration: InputDecoration(
        labelText: isLabelEnabled ? _label : null,
        labelStyle: TextStyle(color: Colors.yellowAccent),
        hintText: _hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.amberAccent,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}