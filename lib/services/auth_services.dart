// ignore_for_file: unused_local_variable
import 'dart:async';
import 'package:all_sm_friends/screens/login/login_screen.dart';
import 'package:all_sm_friends/screens/widget/bottom_NavBar.dart';
import 'package:all_sm_friends/services/firestore_functions.dart';
import 'package:all_sm_friends/services/storage_function.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/crud/create_profile.dart';
import '../screens/home_screen.dart';
import '../shared/methods/navigation.dart';
import '../shared/themes/colors.dart';
import '../shared/themes/text.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  User? myUser = FirebaseAuth.instance.currentUser;
  void createUserByEmail({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
    required String phonenumber,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) async {
          FirestoreServices().createUser(
            name: name,
            number: phonenumber,
            context: context,
            uid: value.user!.uid,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
          ));
          await Future.delayed(Duration(seconds: 1));
          navPushReplacement(
            context: context,
            screen: HomeScreen(),
          );
          BottomNavBar.index = 0;
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Password Error',
          desc: 'The password provided is too weak.',
          descTextStyle: h5.merge(
            TextStyle(color: black),
          ),
          btnCancelText: 'Try Again',
          buttonsTextStyle: h5,
          btnCancelOnPress: () {},
        ).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'email Error',
          desc: 'The account already exists for that email.',
          descTextStyle: h5.merge(
            TextStyle(color: black),
          ),
          btnCancelText: 'Try Again',
          buttonsTextStyle: h5,
          btnCancelOnPress: () {},
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Error',
          desc: e.toString(),
          descTextStyle: h5.merge(
            TextStyle(color: black),
          ),
          btnCancelText: 'Try Again',
          buttonsTextStyle: h5,
          btnCancelOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error',
        desc: e.toString(),
        descTextStyle: h5.merge(
          TextStyle(color: black),
        ),
        btnCancelText: 'Try Again',
        buttonsTextStyle: h5,
        btnCancelOnPress: () {},
      ).show();
    }
  }

  Future<bool> userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool isLoding = false;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        navPushReplacement(context: context, screen: HomeScreen());
        BottomNavBar.index = 0;
      });
      return isLoding = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Email Error',
          desc: 'No user found for that email.',
          descTextStyle: h5.merge(
            TextStyle(color: black),
          ),
          btnCancelText: 'Try Again',
          buttonsTextStyle: h5,
          btnCancelOnPress: () {},
        ).show();
        return isLoding;
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Password Error',
          desc: 'Wrong password provided for that user.',
          descTextStyle: h5.merge(
            TextStyle(color: black),
          ),
          btnCancelText: 'Try Again',
          buttonsTextStyle: h5,
          btnCancelOnPress: () {},
        ).show();
        return isLoding;
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Error',
          desc: e.toString(),
          descTextStyle: h5.merge(
            TextStyle(color: black),
          ),
          btnCancelText: 'Try Again',
          buttonsTextStyle: h5,
          btnCancelOnPress: () {},
        ).show();
        return isLoding;
      }
    }
  }

  void createUserByGoogle({
    required BuildContext context,
    required String name,
    required String phonenumber,
  }) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      // Trigger the authentication flow
      final googleUser =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (value.additionalUserInfo!.isNewUser == true) {
          FirestoreServices().createUser(
            name: name,
            number: phonenumber,
            img: user!.photoURL,
            uid: value.user!.uid,
            context: context,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
          ));
          await Future.delayed(Duration(seconds: 1));
          BottomNavBar.index = 0;
          navPushReplacement(
            context: context,
            screen: HomeScreen(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'User already exists !',
              style: TextStyle(
                color: black,
                fontSize: 16,
              ),
            ),
            backgroundColor: red,
            showCloseIcon: true,
            // closeIconColor: white,
            // duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ));
          await Future.delayed(Duration(seconds: 1));
          BottomNavBar.index = 0;
          navPushReplacement(
            context: context,
            screen: HomeScreen(),
          );
        }
      });
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Google SignIn Error',
        desc: error.toString(),
        descTextStyle: h5.merge(
          TextStyle(color: black),
        ),
        btnCancelText: 'Try Again',
        buttonsTextStyle: h5,
        btnCancelOnPress: () {},
      ).show();
    }
  }

  void loginWithGoogle({required BuildContext context}) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      // Trigger the authentication flow
      final googleUser =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value.additionalUserInfo!.isNewUser == true) {
          FirebaseAuth.instance.currentUser!.delete();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'You have to SignUp first',
              style: TextStyle(
                color: black,
                fontSize: 16,
              ),
            ),
            backgroundColor: red,
            showCloseIcon: true,
            // closeIconColor: white,
            // duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ));
          await Future.delayed(Duration(seconds: 1));
          navPushReplacement(
            context: context,
            screen: CreateProfile(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Successfully LogIn',
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
          ));
          await Future.delayed(Duration(seconds: 1));
          BottomNavBar.index = 0;
          navPushReplacement(
            context: context,
            screen: HomeScreen(),
          );
        }
      });
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Google SignIn Error',
        desc: error.toString(),
        descTextStyle: h5.merge(
          TextStyle(color: black),
        ),
        btnCancelText: 'Try Again',
        buttonsTextStyle: h5,
        btnCancelOnPress: () {},
      ).show();
    }
  }

  // Future<bool> signInWithGoogle({
  //   required BuildContext context,
  //   // required String name,
  //   // required String phonenumber,
  // }) async {
  //   bool isSignedIn = false;
  //   try {
  //     // Sign in with Google
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       // Sign in with credentials
  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       final User? user = userCredential.user;
  //       if (kDebugMode) {
  //         print("User: $user");
  //       }
  //       if (user != null) {
  //         if (userCredential.additionalUserInfo!.isNewUser) {
  //           // Add user to Firestore
  //           await FirebaseFirestore.instance
  //               .collection('users')
  //               .doc(user.uid)
  //               .set({
  //             'name': user.displayName,
  //             'img': user.photoURL,
  //             'number': user.uid,
  //             'socialMediaPlatforms': {}
  //           });
  //         }
  //         isSignedIn = true;
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message!);
  //     isSignedIn = false;
  //   }
  //   return isSignedIn;
  // }

  Future<bool> isRegisteredEmail(
      {required String email, required context}) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      var isRegistered = signInMethods.isNotEmpty;
      return isRegistered;
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Email checking error',
        desc: error.toString(),
        descTextStyle: h5.merge(
          TextStyle(color: black),
        ),
        btnCancelText: 'Try Again',
        buttonsTextStyle: h5,
        // btnCancelOnPress: () {},
      ).show();
    }
    return false;
  }

  Future<void> resetPassword({required String email, required context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Email checking error',
        desc: error.toString(),
        descTextStyle: h5.merge(
          TextStyle(color: black),
        ),
        btnCancelText: 'Try Again',
        buttonsTextStyle: h5,
        // btnCancelOnPress: () {},
      ).show();
    }
  }

  void userLogout({required context}) async {
    //signOut with google
    GoogleSignIn googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    if (googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } else {
      await FirebaseAuth.instance.signOut();
    }
    navPushReplacement(context: context, screen: LoginScreen());
  }

  Future<void> deletUser({required context}) async {
    await StorageServices().deletUserStorage();
    await FirestoreServices().deletUserDocs();
    await myUser?.delete();
    userLogout(context: context);
  }
}
