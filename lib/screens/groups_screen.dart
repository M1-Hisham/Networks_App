import 'package:all_sm_friends/screens/crud/add_new_groups.dart';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/services/firestore_functions.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:all_sm_friends/shared/themes/colors.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:all_sm_friends/shared/widget/loader.dart';
import 'package:flutter/material.dart';
import '../shared/themes/text.dart';
import 'home_screen.dart';
import 'login/login_screen.dart';
import 'widget/bottom_NavBar.dart';
import 'widget/groupitem.dart';

class GroupsScreen extends StatelessWidget {
  GroupsScreen({super.key});
  final myUser = Auth().myUser;
  @override
  Widget build(BuildContext context) {
    return myUser == null
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.home,
                  color: orange,
                  size: 28,
                ),
                onPressed: () {
                  navPushReplacement(context: context, screen: HomeScreen());
                  BottomNavBar.index = 0;
                },
              ),
            ),
            body: Center(
              child: ActionButton(
                titelstyle: h5,
                titel: 'You have to login first -->',
                action: () {
                  navPush(context: context, screen: LoginScreen());
                },
              ),
            ),
            bottomNavigationBar: BottomNavBar(),
          )
        : FutureBuilder(
            future: FirestoreServices().getGroups(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoaderScreen();
              }
              if (snapshot.hasData) {
                var groups = snapshot.data;
                if (groups!.isEmpty) {
                  return Scaffold(
                    appBar: AppBar(
                        leading: BackButton(
                          color: orange,
                        ),
                        title: Text(
                          'Groups',
                          style: h5,
                        )),
                    body: GestureDetector(
                      onTap: () {
                        navPush(context: context, screen: AddNewGroups());
                      },
                      child: GridView.builder(
                        itemCount: 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 25,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              color: Color.fromARGB(63, 34, 195, 157),
                              child: Center(
                                child: Text(
                                  'Add New Group',
                                  style: titel1.merge(
                                      TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          );
                        },
                        physics: BouncingScrollPhysics(),
                        padding:
                            EdgeInsets.only(left: 7.5, right: 7.5, top: 18),
                      ),
                    ),
                    bottomNavigationBar: BottomNavBar(),
                  );
                }
                return Scaffold(
                  extendBody: true,
                  appBar: AppBar(
                      leading: BackButton(
                        color: orange,
                      ),
                      title: Text(
                        'Groups',
                        style: h5,
                      )),
                  body: GridView.builder(
                    itemCount: groups.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 25,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GroupItem(
                        myGroup: groups[index],
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 7.5, right: 7.5, top: 18),
                  ),
                  bottomNavigationBar: BottomNavBar(),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      navPush(context: context, screen: AddNewGroups());
                    },
                    backgroundColor: orange,
                    child: Icon(Icons.add),
                  ),
                );
              } else {
                return Center(
                  child: Text('No Groups..'),
                );
              }
            },
          );
  }
}
