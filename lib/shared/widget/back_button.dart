import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:flutter/material.dart';

import '../themes/colors.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        navPop(context: context);
      },
      icon: Icon(
        Icons.arrow_back,
        size: 30,
        color: orange,
      ),
    );
  }
}
