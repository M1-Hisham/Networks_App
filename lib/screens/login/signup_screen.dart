import 'package:all_sm_friends/screens/crud/create_profile.dart';
import 'package:all_sm_friends/screens/login/login_screen.dart';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/themes/colors.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/action_button.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var passwordNode = FocusNode();
  var emailNode = FocusNode();
  var confirmPasswordNode = FocusNode();
  bool viewPassword = true;
  bool isLoding = false;
  //////////////////////////
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  var numberNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(children: [
                    Center(
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          color: orange,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //the email
                    TextFormField(
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(numberNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name can't be empty";
                        }
                        return null;
                      },
                      controller: name,
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
                          '    User name',
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
                    //the phone number
                    TextFormField(
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailNode);
                      },
                      focusNode: numberNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "number can't be empty";
                        }
                        return null;
                      },
                      controller: number,
                      keyboardType: TextInputType.number,
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
                          '    enter a Phone number',
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
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //the email
                    TextFormField(
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordNode);
                      },
                      focusNode: emailNode,
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
                          ),
                        ),
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
                      height: 15,
                    ),
                    //the password
                    StatefulBuilder(
                      builder: (context, setState) => TextFormField(
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(confirmPasswordNode);
                        },
                        obscureText: viewPassword,
                        focusNode: passwordNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can't be empty";
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
                      height: 15,
                    ),
                    //confirm the password
                    StatefulBuilder(
                      builder: (context, setState) => TextFormField(
                        obscureText: viewPassword,
                        focusNode: confirmPasswordNode,
                        validator: (value) {
                          if (password.text.isEmpty) {
                            return "Password can't be empty";
                          }
                          if (value != password.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        controller: confirmPassword,
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
                            '    confirm the Password',
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
                    ////////////////////////////////////////the button Signup
                    StatefulBuilder(
                      builder: (context, setState) => SizedBox(
                        width: double.infinity,
                        child: ActionButton(
                          isloding: isLoding,
                          titel: 'Signup',
                          titelstyle: titel1,
                          action: () {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                isLoding = true;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                              Auth().createUserByEmail(
                                email: email.text,
                                password: password.text,
                                context: context,
                                name: name.text,
                                phonenumber: number.text,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Text OR
                    Text(
                      'OR',
                      style: h5.merge(
                        TextStyle(color: grey),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //the button login with googel
                    SizedBox(
                      width: double.infinity,
                      child: ActionButton(
                          titel: 'SignUp with Googel',
                          titelstyle: titel1,
                          action: () {
                            navPush(context: context, screen: CreateProfile());
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          navPushReplacement(
                              context: context, screen: LoginScreen());
                        },
                        child: Text(
                          'Already have an account',
                          style: titel1.merge(TextStyle(color: grey)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
