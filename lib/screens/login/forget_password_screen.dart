// ignore_for_file: use_build_context_synchronously

import 'package:all_sm_friends/screens/login/login_screen.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import '../../shared/themes/colors.dart';
import '../../shared/widget/action_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: orange,
          ),
          title: Text('Forget Password'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                //the email
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email can't be empty";
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                      '    enter a valid email',
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
                ),
                SizedBox(
                  height: 20,
                ),
                //the button login
                SizedBox(
                  width: double.infinity,
                  child: ActionButton(
                    titel: 'Reset Password',
                    titelstyle: titel1,
                    action: () async {
                      if (formkey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        var isRegistered = await Auth().isRegisteredEmail(
                            email: emailController.text, context: context);
                        if (isRegistered == true) {
                          //the methode reset password
                          await Auth().resetPassword(
                              email: emailController.text, context: context);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            title: 'Reset Password',
                            desc:
                                'Please Check your email to reset your password 👍',
                            descTextStyle: h5.merge(
                              TextStyle(color: black),
                            ),
                            buttonsTextStyle: h5,
                            btnCancelColor: green,
                            btnCancelText: 'OK',
                            btnCancelOnPress: () {
                              navPushReplacement(
                                  context: context, screen: LoginScreen());
                            },
                          ).show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            title: 'Email Error',
                            desc: 'Email is not correct please check it again',
                            descTextStyle: h5.merge(
                              TextStyle(color: black),
                            ),
                            btnCancelText: 'Try Again',
                            buttonsTextStyle: h5,
                            // btnCancelOnPress: () {        },
                          ).show();
                        }
                      }
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
