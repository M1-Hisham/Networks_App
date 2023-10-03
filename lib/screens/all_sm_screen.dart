import 'package:all_sm_friends/screens/home_screen.dart';
import 'package:all_sm_friends/services/firestore_functions.dart';
import 'package:all_sm_friends/shared/themes/colors.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import '../shared/methods/navigation.dart';
import '../shared/widget/action_button.dart';
import '../shared/widget/loader.dart';
import 'login/login_screen.dart';
import 'widget/bottom_NavBar.dart';
import 'widget/details_friends.dart';

class MyFriendsScreen extends StatelessWidget {
  const MyFriendsScreen({super.key, required this.currentUser});
  final User? currentUser;
  @override
  Widget build(BuildContext context) {
    return currentUser == null
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
            future: FirestoreServices().getUserbyid(id: currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoaderScreen();
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: h1,
                    ),
                  ),
                  floatingActionButton: TextButton(
                    onPressed: () {
                      Auth().userLogout(context: context);
                      Auth().deletUser(context: context);
                    },
                    child: Text(
                      'HELP!',
                      style: h5,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                var user = snapshot.data;
                var myNetwork = user!.uid;
                if (myNetwork.isEmpty) {
                  return Center(
                    child: Text(
                      'isEmpty',
                      style: h1,
                    ),
                  );
                } else {
                  return FutureBuilder(
                    future: FirestoreServices().getNetwork(id: myNetwork),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var myNetworkObj = snapshot.data;
                        var myNetworkList = myNetworkObj!.myNerwork;
                        return Scaffold(
                          extendBody: true,
                          appBar: AppBar(
                            leading: BackButton(
                              color: orange,
                            ),
                            title: Text(
                              'My Friends',
                              style: h5,
                            ),
                          ),
                          body: Padding(
                              padding: EdgeInsets.all(16),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return Friends(
                                    user: myNetworkList[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: myNetworkList.length,
                                physics: BouncingScrollPhysics(),
                              )),
                          bottomNavigationBar: BottomNavBar(),
                        );
                      } else {
                        return LoaderScreen();
                      }
                    },
                  );
                }
              } else {
                return Scaffold(
                  body: Center(
                      child: Text(
                    'NO frinds.',
                    style: h1,
                  )),
                );
              }
            },
          );
  }
}
