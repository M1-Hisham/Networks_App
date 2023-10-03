import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/services/firestore_functions.dart';

import 'package:flutter/material.dart';
import '../../shared/themes/colors.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/action_button.dart';

// ignore: must_be_immutable
class AddNewGroups extends StatelessWidget {
  AddNewGroups({
    super.key,
  });
  final myUser = Auth().myUser;
  final TextEditingController name = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
                          'Add New Group',
                          style: TextStyle(color: orange, fontSize: 44),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      //the email
                      TextFormField(
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
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
                            '    Group Name',
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
                              color: grey,
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
                      //the button login
                      SizedBox(
                        width: double.infinity,
                        child: StatefulBuilder(
                          builder: (context, setState) => ActionButton(
                            // isloding: isLoding,
                            titel: 'Add New Group',
                            titelstyle: titel1,
                            action: () async {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isLoding = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                FirestoreServices().addNewGroups(
                                    name: name.text, context: context);
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
