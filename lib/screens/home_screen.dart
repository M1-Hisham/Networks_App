import 'package:all_sm_friends/screens/search_screen.dart';
import 'package:all_sm_friends/shared/themes/colors.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:flutter/material.dart';
import '../shared/methods/navigation.dart';
import 'widget/bottom_NavBar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBody: true,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onSubmitted: (value) {
                    navPush(
                        context: context,
                        screen: SearchScreen(
                          phoneNumber: value,
                        ));
                  },
                  controller: number,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text(
                      '    enter the phone number',
                      style: body.merge(TextStyle(color: orange)),
                    ),
                    //hintText: 'enter the phone number', hintStyle: body,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                      borderSide: BorderSide(
                        color: orange,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70),
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
                  height: 23,
                ),
                ActionButtonicon(
                    titel: 'Search',
                    icon: Icons.search,
                    action: () {
                      navPush(
                          context: context,
                          screen: SearchScreen(phoneNumber: number.text));
                    }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
