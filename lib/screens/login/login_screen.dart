import 'package:all_sm_friends/screens/login/signup_screen.dart';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/methods/navigation.dart';
import '../../shared/themes/colors.dart';
import 'forget_password_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formkey = GlobalKey<FormState>();
  FocusNode passwordNode = FocusNode();
  bool viewPassword = true;
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //the email
                      TextFormField(
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passwordNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can't be empty";
                          }
                          return null;
                        },
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: orange,
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
                            '    enter the Email',
                            style: body.merge(TextStyle(color: orange)),
                          ),
                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: orange,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: orange,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: orange,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //the password
                      StatefulBuilder(
                        builder: (context, setState) => TextFormField(
                          obscureText: viewPassword,
                          focusNode: passwordNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password can't be empty";
                            }
                            return null;
                          },
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                viewPassword = !viewPassword;
                                setState(() {});
                              },
                              icon: viewPassword
                                  ? Icon(
                                      FontAwesomeIcons.eyeSlash,
                                      size: 20,
                                      color: grey,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.eye,
                                      size: 20,
                                      color: white,
                                    ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: orange,
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
                              '    enter the Password',
                              style: body.merge(TextStyle(color: orange)),
                            ),
                            //hintText: 'enter the phone number', hintStyle: body,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: orange,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: orange,
                                width: 2,
                              ),
                            ),
                          ),
                          cursorColor: white,
                          style: titel1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //the button login
                      StatefulBuilder(
                        builder: (context, setState) => SizedBox(
                          width: double.infinity,
                          child: ActionButton(
                            isloding: isLoding,
                            titel: 'Login',
                            titelstyle: titel1,
                            action: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isLoding = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Auth().userLogin(
                                  email: email.text,
                                  password: password.text,
                                  context: context,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //forget my password
                      TextButton(
                        onPressed: () {
                          navPush(
                              context: context, screen: ForgetPasswordScreen());
                        },
                        child: Text(
                          'Forget my password',
                          style: titel1.merge(TextStyle(color: grey)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //the button login with googel
                      SizedBox(
                        width: double.infinity,
                        child: ActionButton(
                          titel: 'Login with Googel',
                          titelstyle: titel1,
                          action: () {
                            Auth().loginWithGoogle(context: context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          navPushReplacement(
                              context: context, screen: SignupScreen());
                        },
                        child: Text(
                          'Don\'t have an account',
                          style: titel1.merge(TextStyle(color: grey)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
