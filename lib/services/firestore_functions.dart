import 'package:all_sm_friends/screens/groups_screen.dart';
import 'package:all_sm_friends/screens/widget/bottom_NavBar.dart';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/all_sm_screen.dart';
import '../screens/profile_screen.dart';
import '../shared/themes/colors.dart';
import 'models.dart';

class FirestoreServices {
  var firestoreRef = FirebaseFirestore.instance;
  var usercolRef = FirebaseFirestore.instance.collection('users');
  var networkscolRef = FirebaseFirestore.instance.collection('network');
  var myUser = FirebaseAuth.instance.currentUser;
  var currentUser = Auth().myUser;
  createUser({
    required String name,
    required String number,
    required String uid,
    String? img,
    required context,
  }) async {
    var ref = usercolRef.doc(uid);
    var user = MyUser(
      name: name,
      phoneNumber: number,
      img: img!,
    );
    await ref.set(user.toMap());
    var refNet = networkscolRef.doc(uid);
    var userNet = MyNetwork();
    await refNet.set(userNet.toMap());
  }

  // Future<MyUser> getUser() async {
  //   var ref = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('vlWvBkIjTMuqNV9mr3bd');
  //   var myData = await ref.get();
  //   var theTrueData = MyUser().fromMap(myData.data());
  //   theTrueData.uid = ref.id;
  //   return theTrueData;
  // }

  Future<MyUser> getUserbyid({required String id}) async {
    var ref = usercolRef.doc(id);
    var myData = await ref.get();
    var theTrueData = MyUser().fromMap(myData.data());
    theTrueData.uid = ref.id;
    return theTrueData;
  }

  Future<MyNetwork> getNetwork({required String id}) async {
    var ref = networkscolRef.doc(id);
    var myData = await ref.get();
    var theTrueData = MyNetwork().fromMap(myData.data());
    return theTrueData;
  }

  // Stream<List<MyUser>> getNetworkbystream() {
  //   return usercolRef.snapshots().map(
  //         (event) => event.docs
  //             .map((e) => MyUser().fromMap(
  //                   e.data(),
  //                 ))
  //             .toList(),
  //       );
  // }

  // Future<List<MyUser>> getNetworkbyFuture() async {
  //   var ref = FirebaseFirestore.instance.collection('users');
  //   var myData = await ref.get();
  //   var myUserDocs = myData.docs.map((e) => e.data());
  //   var theTrueData = myUserDocs.map((e) => MyUser().fromMap(e));
  //   return theTrueData.toList();
  // }

  Future<List<MyUser>> searchforcontact({required String number}) async {
    var ref = FirebaseFirestore.instance.collection('users');
    var myData = await ref.where('number', isEqualTo: number).get();
    var myUserDocs = myData.docs.map((e) => e.data());
    var theTrueData = myUserDocs.map((e) => MyUser().fromMap(e));
    var myUserID = myData.docs.map((e) => e.id);
    var theTrueDataList = theTrueData.toList();
    var myUserIDList = myUserID.toList();
    for (int i = 0; i < theTrueDataList.length; i++) {
      theTrueDataList[i].uid = myUserIDList[i];
    }
    return theTrueDataList;
  }

  Future<List<Group>> getGroups() async {
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('groups');
    var myData = await ref.get();
    var groupDocs = myData.docs.map((e) => e.data());
    var theTrueData = groupDocs.map((e) => Group().fromMap(e));
    var myUserID = myData.docs.map((e) => e.id);
    var theTrueDataList = theTrueData.toList();
    var myUserIDList = myUserID.toList();
    for (int i = 0; i < theTrueDataList.length; i++) {
      theTrueDataList[i].uid = myUserIDList[i];
    }
    return theTrueDataList;
  }

  void addcontactToNetwork(
      {required String contactID, required context}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'User Added Successfully',
          style: TextStyle(
            color: black,
            fontSize: 16,
          ),
        ),
        backgroundColor: orange,
        showCloseIcon: true,
        // closeIconColor: white,
        // duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'go to',
          onPressed: () {
            BottomNavBar.index = 1;
            navPush(
              context: context,
              screen: MyFriendsScreen(
                currentUser: currentUser,
              ),
            );
          },
        ),
      ),
    );
    await FirebaseFirestore.instance
        .collection('network')
        .doc(myUser!.uid)
        .update(
      {
        'myNetwork': FieldValue.arrayUnion([contactID]),
      },
    );
    await Future.delayed(
      Duration(seconds: 2),
    );
  }

  void addcontactToGroups(
      {required String groupID,
      required String friends,
      required context}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('groups')
        .doc(groupID)
        .update(
      {
        'members': FieldValue.arrayUnion([friends]),
      },
    );
    navPush(context: context, screen: GroupsScreen());
    BottomNavBar.index = 2;
  }

  void addNewGroups({required String name, required context}) async {
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('groups');
    var theNewGroup = Group(name: name);
    await ref.add(theNewGroup.toMap());
    BottomNavBar.index = 2;
    navPushReplacement(context: context, screen: GroupsScreen());
  }

  void updateProfileData({
    required String updateName,
    required String updateNumber,
    required context,
    String? updatefacebook,
    String? updateinstagram,
    String? updatewhatsapp,
    String? updateyoutube,
    String? updategithub,
    String? updatelinkedin,
    String? updatetiktok,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update(
      {
        'name': updateName,
        'number': updateNumber,
        // 'socialMediaPlatforms.facebook': updatefacebook,
        // 'socialMediaPlatforms.instagram': updateinstagram,
        // 'socialMediaPlatforms.whatsapp': updatewhatsapp,
        // 'socialMediaPlatforms.youtube': updateyoutube,
        if (updatefacebook!.isNotEmpty)
          'socialMediaPlatforms.facebook': updatefacebook,
        if (updateinstagram!.isNotEmpty)
          'socialMediaPlatforms.instagram': updateinstagram,
        if (updatewhatsapp!.isNotEmpty)
          'socialMediaPlatforms.whatsapp': updatewhatsapp,
        if (updateyoutube!.isNotEmpty)
          'socialMediaPlatforms.youtube': updateyoutube,
        if (updategithub!.isNotEmpty)
          'socialMediaPlatforms.github': updategithub,
        if (updatelinkedin!.isNotEmpty)
          'socialMediaPlatforms.linkedin': updatelinkedin,
        if (updatetiktok!.isNotEmpty)
          'socialMediaPlatforms.tiktok': updatetiktok,
      },
    );
    navPushReplacement(
      context: context,
      screen: ProfileScreen(
        currentUser: currentUser,
      ),
    );
  }

  void updateProfileImage({
    required context,
    required imageUrl,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update(
      {'img': imageUrl},
    );
    navPushReplacement(
        context: context, screen: ProfileScreen(currentUser: currentUser));
  }

  void updateGroupImage({
    required context,
    required imageUrl,
    required groupId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('groups')
        .doc(groupId)
        .update(
      {'img': imageUrl},
    );
    navPushReplacement(context: context, screen: GroupsScreen());
  }

  Future<void> deletUserDocs() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('groups')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('network')
          .doc(currentUser!.uid)
          .delete();
      print('تم الحذف بنجاح');
    } catch (e) {
      print('حدث خطاء $e');
    }
  }
}
