import 'package:flutter/material.dart';

//push
void navPush({required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

//pop
void navPop({
  required BuildContext context,
}) {
  Navigator.pop(
    context,
  );
}

//pushReplacement
void navPushReplacement(
    {required BuildContext context, required Widget screen}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
