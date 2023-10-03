import 'dart:io';
import 'package:all_sm_friends/screens/crud/edit_profile.dart';
import 'package:all_sm_friends/screens/crud/update_profile_image.dart';
import 'package:all_sm_friends/screens/home_screen.dart';
import 'package:all_sm_friends/screens/login/login_screen.dart';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/services.dart';
import '../shared/methods/check_network_image.dart';
import '../shared/themes/colors.dart';
import '../shared/widget/action_button.dart';
import '../shared/widget/loader.dart';
import 'widget/bottom_NavBar.dart';
import 'widget/social_media_icon.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.currentUser});
  final User? currentUser;
  final Map<String, dynamic> social = {};
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
                    child: Text(snapshot.error.toString()),
                  ),
                  floatingActionButton: TextButton(
                    onPressed: () {
                      Auth().userLogout(context: context);
                      // Auth().deletUser(context: context);
                    },
                    child: Text(
                      'HELP!',
                      style: h5,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                MyUser profileOwner;
                profileOwner = snapshot.data!;
                return Scaffold(
                  extendBody: true,
                  appBar: AppBar(
                    leading: BackButton(
                      color: orange,
                    ),
                    // titleSpacing: 16,
                    title: Text(
                      profileOwner.name,
                      style: h4,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Auth().userLogout(context: context);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: orange,
                          size: 26,
                        ),
                      ),
                    ],
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
                          SizedBox(
                            height: 260,
                            width: 260,
                            child: Stack(children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(63, 34, 195, 157),
                                radius: 130,
                                child: profileOwner.img.isEmpty
                                    ? Text(
                                        profileOwner.name[0].toUpperCase(),
                                        style: h1.merge(
                                          TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 120),
                                        ),
                                      )
                                    : FutureBuilder(
                                        future: isvalidNetworkImage(
                                            url: profileOwner.img),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Loader();
                                          } else if (snapshot.hasError ||
                                              snapshot.data == false) {
                                            return Text(
                                              profileOwner.name[0]
                                                  .toUpperCase(),
                                              style: h1.merge(
                                                TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 120,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(130),
                                              child: Image(
                                                image: NetworkImage(
                                                    profileOwner.img),
                                                fit: BoxFit.cover,
                                                height: 260,
                                                width: 260,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton.small(
                                    backgroundColor:
                                        Color.fromARGB(124, 34, 195, 157),
                                    child:
                                        Icon(Icons.mode_edit_outline_outlined),
                                    onPressed: () async {
                                      File imageFile;
                                      var imagePicker = ImagePicker();
                                      var pickedimage =
                                          await imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                      if (pickedimage == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('No image was selected'),
                                            duration: Duration(seconds: 1),
                                            backgroundColor: orange,
                                          ),
                                        );
                                      } else {
                                        imageFile = File(pickedimage.path);
                                        navPush(
                                            context: context,
                                            screen: UpdateProfileImage(
                                                myimage: imageFile));
                                      }
                                    },
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            profileOwner.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ActionButtonicon(
                                color: grey,
                                titel: ('Edit profile'),
                                icon: Icons.edit,
                                action: () {
                                  navPush(
                                      context: context,
                                      screen: EditProfile(
                                        user: profileOwner,
                                      ));
                                },
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              ActionButton(
                                  color: red,
                                  titel: ('Delete'),
                                  action: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Delete Profile',
                                              style: h4.merge(
                                                  TextStyle(color: black))),
                                          content: Text(
                                              'Are you sure want to delete your profile ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                'cansel',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                'ok',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await Auth().deletUser(
                                                    context: context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                profileOwner.phoneNumber,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await launchUrl(Uri.parse(
                                      'tel:${profileOwner.phoneNumber}'));
                                },
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          profileOwner.socialMediaPlatforms.isEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    navPush(
                                        context: context,
                                        screen:
                                            EditProfile(user: profileOwner));
                                  },
                                  child: GridView.builder(
                                    itemCount: 1,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      // crossAxisSpacing: 20.0,
                                      // mainAxisSpacing: 25,
                                      crossAxisCount: 3,
                                    ),
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          color: Color.fromARGB(18, 51, 70, 85),
                                          child: Center(
                                            child: Text(
                                              'Add Social Media',
                                              textAlign: TextAlign.center,
                                              style: titel1.merge(TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    // physics: BouncingScrollPhysics(),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                  ),
                                )
                              : GridView.builder(
                                  itemCount:
                                      profileOwner.socialMediaPlatforms.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    //crossAxisSpacing: 20.0,
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return SmIcon(
                                      sm: profileOwner.socialMediaPlatforms.keys
                                          .toList()[index],
                                      smlink: profileOwner
                                          .socialMediaPlatforms.values
                                          .toList()[index],
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(20),
                                ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: BottomNavBar(),
                );
              } else {
                return Scaffold(
                  body: Center(child: Text('NO profile was found.')),
                  floatingActionButton: TextButton(
                    onPressed: () {
                      Auth().userLogout(context: context);
                    },
                    child: Text(
                      'HELP!',
                      style: h5,
                    ),
                  ),
                );
              }
            },
          );
  }
}
