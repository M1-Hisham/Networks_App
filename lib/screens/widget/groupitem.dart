import 'package:all_sm_friends/services/models.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:all_sm_friends/shared/themes/text.dart';
import 'package:flutter/material.dart';
import '../../shared/methods/check_network_image.dart';
import '../../shared/widget/loader.dart';
import '../singile_group_screen.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.myGroup});
  final Group myGroup;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navPush(
          context: context,
          screen: SingleGroupScreen(
            myGroup: myGroup,
          ),
        );
      },
      child: myGroup.img.isEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Color.fromARGB(63, 34, 195, 157),
                child: Center(
                  child: Text(
                    myGroup.name,
                    style: h2.merge(TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          : FutureBuilder(
              future: isvalidNetworkImage(url: myGroup.img),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: Color.fromARGB(63, 34, 195, 157),
                      child: Center(
                        child: Text(
                          myGroup.name,
                          style:
                              h2.merge(TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(myGroup.img),
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(100, 0, 0, 0), BlendMode.darken),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        myGroup.name,
                        style: h2.merge(TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
