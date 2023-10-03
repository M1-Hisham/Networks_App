import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/services.dart';
import '../shared/methods/check_network_image.dart';
import '../shared/themes/colors.dart';
import '../shared/widget/action_button.dart';
import '../shared/widget/loader.dart';
import 'widget/bottom_NavBar.dart';
import 'widget/social_media_icon.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key, required this.friend});
  final MyUser friend;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: BackButton(
          color: orange,
        ),
        title: Text(
          friend.name,
        ),
      ),
      body: SingleChildScrollView(
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
              child: friend.img.isEmpty
                  ? Text(
                      friend.name[0].toUpperCase(),
                      style: h1.merge(
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 120),
                      ),
                    )
                  : FutureBuilder(
                      future: isvalidNetworkImage(url: friend.img),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loader();
                        } else if (snapshot.hasError ||
                            snapshot.data == false) {
                          return Text(
                            friend.name[0].toUpperCase(),
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
                              image: NetworkImage(friend.img),
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
              friend.name,
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
              titel: ('Add to a group'),
              icon: Icons.add_circle_outline_outlined,
              action: () {
                showModalBottomSheet<void>(
                  backgroundColor: transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return FutureBuilder(
                      future: FirestoreServices().getGroups(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoaderScreen();
                        } else if (snapshot.hasError) {
                          return Scaffold(
                            body: Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: h1,
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          var myGroups = snapshot.data;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18)),
                              color: orange,
                            ),
                            height: 230,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(13),
                                      ),
                                      color: black,
                                    ),
                                    width: 60,
                                    height: 10,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 16),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ListView.separated(
                                        itemCount: myGroups!.length,
                                        itemBuilder: (context, index) => Align(
                                          alignment: Alignment.bottomLeft,
                                          child: TextButton(
                                            onPressed: () {
                                              FirestoreServices()
                                                  .addcontactToGroups(
                                                      context: context,
                                                      groupID:
                                                          myGroups[index].uid,
                                                      friends: friend.uid);
                                            },
                                            child: Text(
                                              '. ${myGroups[index].name}',
                                              style: h4,
                                            ),
                                          ),
                                        ),
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Scaffold(
                            body: Center(
                                child: Text(
                              'NO Groups.',
                              style: h1,
                            )),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  friend.phoneNumber,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse('tel:${friend.phoneNumber}'));
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
              itemCount: friend.socialMediaPlatforms.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //crossAxisSpacing: 20.0,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return SmIcon(
                  sm: friend.socialMediaPlatforms.keys.toList()[index],
                  smlink: friend.socialMediaPlatforms.values.toList()[index],
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
      bottomNavigationBar: BottomNavBar(selectedItemColor: grey),
    );
  }
}
