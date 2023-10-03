import 'package:all_sm_friends/screens/friends_screen.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:flutter/material.dart';
import '../../services/firestore_functions.dart';
import '../../shared/methods/check_network_image.dart';
import '../../shared/themes/colors.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/loader.dart';

class Friends extends StatelessWidget {
  const Friends({super.key, required this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreServices().getUserbyid(id: user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        if (snapshot.hasData) {
          var friend = snapshot.data;
          return InkWell(
            onTap: () {
              navPush(
                  context: context,
                  screen: FriendsScreen(
                    friend: friend,
                  ));
            },
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: Color.fromARGB(63, 34, 195, 157),
                    radius: 40,
                    child: friend!.img.isEmpty
                        ? Text(
                            friend.name[0].toUpperCase(),
                            style: h1.merge(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                                    ),
                                  ),
                                );
                              } else {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image(
                                    image: NetworkImage(friend.img),
                                    fit: BoxFit.cover,
                                    height: 80,
                                    width: 80,
                                  ),
                                );
                              }
                            },
                          )
                    // isvalidNetworkImage(url: friend.img) == true
                    //     ? Image(
                    //         image: NetworkImage(friend.img),
                    //       )
                    //     : Text(
                    //         friend.name[1].toUpperCase(),
                    //         style: h1.merge(
                    //           TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.name,
                        style: h5,
                      ),
                      Text(
                        friend.phoneNumber,
                        style: titel1.merge(TextStyle(color: grey)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
