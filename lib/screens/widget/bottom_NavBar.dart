
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/methods/navigation.dart';
import '../../shared/themes/colors.dart';
import '../all_sm_screen.dart';
import '../groups_screen.dart';
import '../home_screen.dart';
import '../profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, this.selectedItemColor});
  static int index = 0;
  final Color? selectedItemColor;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: BottomNavigationBar(
        backgroundColor: Color.fromARGB(48, 145, 145, 145),
        unselectedItemColor: grey,
        selectedItemColor: selectedItemColor ?? orange,
        onTap: (value) {
          if (value == 0) {
            index = value;
            navPushReplacement(context: context, screen: HomeScreen());
          } else if (value == 1) {
            index = value;
            navPushReplacement(
                context: context,
                screen: MyFriendsScreen(currentUser: Auth().myUser));
          } else if (value == 2) {
            index = value;
            navPushReplacement(context: context, screen: GroupsScreen());
          } else if (value == 3) {
            index = value;
            navPushReplacement(
                context: context,
                screen: ProfileScreen(currentUser: Auth().myUser));
          }
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.globe),
            label: 'net',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userGroup),
            label: 'group',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: "user",
          ),
        ],
      ),
    );
  }
}
