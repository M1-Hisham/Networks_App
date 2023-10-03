import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:all_sm_friends/shared/widget/loader.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: FutureBuilder(
        future: Auth().isRegisteredEmail(email: email, context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          } else if (snapshot.hasError || snapshot.data == false) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email is not correct please check it again',
                        style: h4,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ActionButton(
                        titelstyle: h4,
                        titel: 'Rewrite Email',
                        action: () {
                          Navigator.pop(context);
                        },
                      )
                    ]),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Please Check your email to reset your password 👍',
                style: h4,
              ),
            );
          }
        },
      ),
    );
  }
}
