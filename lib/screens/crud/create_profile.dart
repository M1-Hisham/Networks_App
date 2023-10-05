import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import '../../shared/themes/colors.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/action_button.dart';

// ignore: must_be_immutable
class CreateProfile extends StatelessWidget {
  CreateProfile({
    super.key,
  });
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FocusNode passwordNode = FocusNode();
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Create User',
                          style: TextStyle(
                              color: orange,
                              fontSize: 50,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      //the email
                      TextFormField(
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passwordNode);
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
                      //the number
                      TextFormField(
                        focusNode: passwordNode,
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
                      //the button create user
                      SizedBox(
                        width: double.infinity,
                        child: StatefulBuilder(
                          builder: (context, setState) => ActionButton(
                            isloding: isLoding,
                            titel: 'Create User',
                            titelstyle: titel1,
                            action: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isLoding = true;
                                });
                                Auth().createUserByGoogle(
                                  context: context,
                                  name: name.text,
                                  phonenumber: number.text,
                                );
                              }
                            },
                          ),
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
