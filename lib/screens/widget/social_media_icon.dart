import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SmIcon extends StatelessWidget {
  String sm;
  String smlink;
  SmIcon({
    Key? key,
    required this.sm,
    required this.smlink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sm == 'whatsapp' ? smlink = 'https://wa.me/$smlink' : smlink;
    return Padding(
      padding: const EdgeInsets.all(17),
      child: InkWell(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/$sm.png'),
          radius: 40,
        ),
        onTap: () =>
            launchUrl(Uri.parse(smlink), mode: LaunchMode.externalApplication),
      ),
    );
  }
}
