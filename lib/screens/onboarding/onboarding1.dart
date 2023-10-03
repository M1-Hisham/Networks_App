import 'package:all_sm_friends/screens/onboarding/onboarding2.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:flutter/material.dart';
import '../../shared/methods/navigation.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

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
                child: Image.asset('assets/Onboarding1.png'),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                'Welcome Everyone \n To the app \n All Social Media',
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
              navPushReplacement(context: context, screen: Onboarding2()),
        ),
      ),
    );
  }
}
