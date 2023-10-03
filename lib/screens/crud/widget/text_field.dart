import 'package:flutter/material.dart';
import '../../../shared/themes/colors.dart';
import '../../../shared/themes/text.dart';

class TextField extends StatelessWidget {
  TextField({super.key, required TextInputType textInputType});
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FocusNode passwordNode = FocusNode();

  final TextInputType textInputType = TextInputType.none;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(passwordNode);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name can't be empty";
        }
        return null;
      },
      controller: name,
      keyboardType: textInputType,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: white,
              width: 2,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: red,
            width: 2,
          ),
        ),
        label: Text(
          '    User name',
          style: body.merge(TextStyle(color: grey.shade400)),
        ),
        //hintText: 'enter the phone number', hintStyle: body,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: white,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: grey,
            width: 2,
          ),
        ),
      ),
      cursorColor: white,
      style: titel1,
    );
  }
}
