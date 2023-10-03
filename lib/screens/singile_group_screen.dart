import 'dart:io';
import 'package:all_sm_friends/services/models.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../shared/methods/check_network_image.dart';
import '../shared/methods/navigation.dart';
import '../shared/themes/colors.dart';
import '../shared/widget/loader.dart';
import 'crud/update_group_image.dart';
import 'widget/bottom_NavBar.dart';
import 'widget/details_friends.dart';

class SingleGroupScreen extends StatelessWidget {
  const SingleGroupScreen({super.key, required this.myGroup});
  final Group myGroup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          leading: BackButton(
            color: orange,
          ),
          title: Text(
            myGroup.name,
            style: h5,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 225,
              child: Stack(
                children: [
                  myGroup.img.isEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Color.fromARGB(63, 34, 195, 157),
                            height: 225,
                            child: Center(
                              child: Text(
                                myGroup.name,
                                style: h1.merge(TextStyle(fontSize: 60)),
                              ),
                            ),
                          ),
                        )
                      : FutureBuilder(
                          future: isvalidNetworkImage(url: myGroup.img),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Loader();
                            } else if (snapshot.hasError ||
                                snapshot.data == false) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  color: orange,
                                  height: 225,
                                  child: Center(
                                    child: Text(
                                      myGroup.name,
                                      style: h1.merge(TextStyle(fontSize: 60)),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 225,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(myGroup.img),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                  // Container(
                  //               height: 225,
                  //               decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                   fit: BoxFit.cover,
                  //                   image: NetworkImage(myGroup.img),
                  //                 ),
                  //                 borderRadius: BorderRadius.all(
                  //                   Radius.circular(20),
                  //                 ),
                  //               ),
                  //             ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.small(
                      backgroundColor: Color.fromARGB(124, 34, 195, 157),
                      child: Icon(Icons.mode_edit_outline_outlined),
                      onPressed: () async {
                        File imageFile;
                        var imagePicker = ImagePicker();
                        var pickedimage = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (pickedimage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No image was selected'),
                              duration: Duration(seconds: 1),
                              backgroundColor: orange,
                            ),
                          );
                        } else {
                          imageFile = File(pickedimage.path);
                          navPush(
                              context: context,
                              screen: UpdateGroupImage(
                                myimage: imageFile,
                                groupId: myGroup.uid,
                              ));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Groub Members',
              style: h2,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Friends(user: myGroup.members[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemCount: myGroup.members.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedItemColor: grey),
    );
  }
}
