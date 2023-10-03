import 'dart:io';
import 'package:all_sm_friends/services/auth_services.dart';
import 'package:all_sm_friends/services/storage_function.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:all_sm_friends/shared/widget/action_button.dart';
import 'package:all_sm_friends/shared/widget/loader.dart';
import 'package:flutter/material.dart';
import '../../shared/themes/colors.dart';

// ignore: must_be_immutable
class UpdateGroupImage extends StatelessWidget {
  UpdateGroupImage({
    super.key,
    required this.myimage,
    required this.groupId,
  });
  File myimage;
  String groupId;
  final user = Auth().myUser;
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: orange,
          ),
          title: Text('Upload Group Image', style: h5),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 225,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(myimage),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
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
                              StorageServices().uploadGroupImage(
                                  imagefile: myimage,
                                  context: context,
                                  groupId: groupId);
                            },
                          )
                        : Loader()),
              ],
            ),
          ),
        ));
  }
}
