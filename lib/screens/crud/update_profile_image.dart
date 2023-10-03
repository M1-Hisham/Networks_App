import 'dart:io';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/services/storage_function.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:flutter/material.dart';
import '../../shared/themes/colors.dart';
import '../../shared/widget/loader.dart';

// ignore: must_be_immutable
class UpdateProfileImage extends StatelessWidget {
  UpdateProfileImage({super.key, required this.myimage});
  File myimage;

  final user = Auth().myUser;
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: orange,
          ),
          title: Text('Upload Profile Image', style: h5),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundImage: FileImage(myimage),
                radius: 130,
              ),
              SizedBox(
                height: 20,
              ),
              StatefulBuilder(
                  builder: (context, setState) => isLoding != true
                      ? ActionButton(
                          // isloding: isLoding,
                          titel: 'Upload Imgae',
                          titelstyle: h5,
                          action: () {
                            setState(() {
                              isLoding = true;
                            });
                            StorageServices().uploadProfileImage(
                              imagefile: myimage,
                              context: context,
                            );
                          },
                        )
                      : Loader()),
            ],
          ),
        ));
  }
}
