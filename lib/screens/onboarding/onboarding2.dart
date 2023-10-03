import 'package:all_sm_friends/screens/onboarding/onboarding3.dart';
import 'package:flutter/material.dart';
import '../../shared/methods/navigation.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/action_button.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Image.asset('assets/onboarding2.webp'),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                'Please create your own account, \n share it with your friends \n on your social media sites',
                style: h5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 6),
        child: ActionButton(
          titel: 'Next',
          action: () =>
              navPushReplacement(context: context, screen: Onboarding3()),
        ),
      ),
    );
  }
}
