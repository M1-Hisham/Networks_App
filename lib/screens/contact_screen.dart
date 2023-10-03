import 'package:all_sm_friends/screens/friends_screen.dart';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/services/firestore_functions.dart';
import 'package:all_sm_friends/services/models.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/methods/check_network_image.dart';
import '../shared/methods/navigation.dart';
import '../shared/themes/colors.dart';
import '../shared/themes/text.dart';
import '../shared/widget/loader.dart';
import 'home_screen.dart';
import 'login/login_screen.dart';
import 'widget/bottom_NavBar.dart';
import 'widget/social_media_icon.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key, required this.contact});
  final MyUser contact;
  final contactUser = Auth().myUser;
  @override
  Widget build(BuildContext context) {
    return contactUser == null
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
            bottomNavigationBar: BottomNavBar(selectedItemColor: grey),
          )
        : Scaffold(
            extendBody: true,
            appBar: AppBar(
              leading: BackButton(
                color: orange,
              ),
              title: Text(contact.name),
            ),
            body: SizedBox(
              width: double.infinity,
              //color: Colors.red,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 13,
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(63, 34, 195, 157),
                      radius: 130,
                      child: contact.img.isEmpty
                          ? Text(
                              contact.name[0].toUpperCase(),
                              style: h1.merge(
                                TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 120),
                              ),
                            )
                          : FutureBuilder(
                              future: isvalidNetworkImage(url: contact.img),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Loader();
                                } else if (snapshot.hasError ||
                                    snapshot.data == false) {
                                  return Text(
                                    contact.name[0].toUpperCase(),
                                    style: h1.merge(
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 120,
                                      ),
                                    ),
                                  );
                                } else {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(130),
                                    child: Image(
                                      image: NetworkImage(contact.img),
                                      fit: BoxFit.cover,
                                      height: 260,
                                      width: 260,
                                    ),
                                  );
                                }
                              },
                            ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      contact.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ActionButtonicon(
                      titel: ('Add to a Network'),
                      icon: Icons.add_circle_outline_outlined,
                      action: () async {
                        FirestoreServices().addcontactToNetwork(
                            contactID: contact.uid, context: context);
                        navPush(
                            context: context,
                            screen: FriendsScreen(friend: contact));
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          contact.phoneNumber,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse('tel:+201151771702'));
                          },
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      itemCount: contact.socialMediaPlatforms.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //crossAxisSpacing: 20.0,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return SmIcon(
                          sm: contact.socialMediaPlatforms.keys.toList()[index],
                          smlink: contact.socialMediaPlatforms.values
                              .toList()[index],
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavBar(selectedItemColor: grey),
          );
  }
}
