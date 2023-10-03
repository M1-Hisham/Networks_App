import 'package:all_sm_friends/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../../shared/methods/navigation.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/action_button.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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
                child: Image.asset('assets/Onborading33.png'),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                'Let\'s Go To \n Your Application',
                style: h4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 6),
        child: ActionButton(
          titel: 'Start',
          action: () =>
              navPushReplacement(context: context, screen: LoginScreen()),
        ),
      ),
    );
  }
}
