import 'dart:io';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/services/firestore_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  var user = Auth().myUser;
  Future<void> uploadProfileImage(
      {required File imagefile, required context}) async {
    var ref = FirebaseStorage.instance.ref();
    var imageRef = ref.child('users/${user!.uid}/${user!.uid}');
    var uploadedImage = await imageRef.putFile(imagefile);
    var imageUrl = await uploadedImage.ref.getDownloadURL();
    FirestoreServices()
        .updateProfileImage(context: context, imageUrl: imageUrl);
  }

  Future<void> uploadGroupImage({
    required File imagefile,
    required context,
    required groupId,
  }) async {
    var path = DateTime.now().microsecondsSinceEpoch;
    var ref = FirebaseStorage.instance.ref();
    var imageRef = ref.child(
      'users/${user!.uid}/groups/${path.toString()}',
    );
    var uploadedImage = await imageRef.putFile(imagefile);
    var imageUrl = await uploadedImage.ref.getDownloadURL();
    FirestoreServices().updateGroupImage(
        context: context, imageUrl: imageUrl, groupId: groupId);
  }

  Future<void> deletUserStorage() async {
    await FirebaseStorage.instance.ref('users/${user!.uid}').listAll().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.items.forEach(
            (element) async {
              await FirebaseStorage.instance.ref(element.fullPath).delete();
            },
          ),
        );
    await FirebaseStorage.instance
        .ref('users/${user!.uid}/groups')
        .listAll()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.items.forEach(
            (element) async {
              await FirebaseStorage.instance.ref(element.fullPath).delete();
            },
          ),
        );
  }
}
