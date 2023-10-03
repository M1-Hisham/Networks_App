import 'package:all_sm_friends/shared/themes/colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      this.isloding,
      required this.titel,
      required this.action,
      this.color,
      this.titelstyle});
  final String titel;
  final Function() action;
  final Color? color;
  final TextStyle? titelstyle;
  final bool? isloding;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? orange,
          //fixedSize: Size(50, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: isloding != true
          ? Text(
              titel,
              style: titelstyle,
            )
          : Text(
              'Loading.....',
              style: titelstyle,
            ),
    );
  }
}

class ActionButtonicon extends StatelessWidget {
  const ActionButtonicon(
      {super.key,
      required this.titel,
      required this.icon,
      required this.action,
      this.color});
  final String titel;
  final IconData icon;
  final VoidCallback action;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: action,
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? orange,
          //fixedSize: Size(50, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      icon: Icon(icon),
      label: Text(titel),
    );
  }
}
