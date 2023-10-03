import 'package:all_sm_friends/services/models.dart';
import 'package:all_sm_friends/shared/methods/navigation.dart';
import 'package:flutter/material.dart';
import '../../shared/methods/check_network_image.dart';
import '../../shared/themes/colors.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/loader.dart';
import '../contact_screen.dart';

class SearchDetails extends StatelessWidget {
  const SearchDetails({super.key, required this.contact});
  final MyUser contact;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navPush(
          context: context,
          screen: ContactScreen(contact: contact),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(63, 34, 195, 157),
            radius: 40,
            child: contact.img.isEmpty
                ? Text(
                    contact.name[0].toUpperCase(),
                    style: h1.merge(
                      TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : FutureBuilder(
                    future: isvalidNetworkImage(url: contact.img),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loader();
                      } else if (snapshot.hasError || snapshot.data == false) {
                        return Text(
                          contact.name[0].toUpperCase(),
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
                            image: NetworkImage(contact.img),
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        );
                      }
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: h5,
                ),
                Text(
                  contact.phoneNumber,
                  style: titel1.merge(TextStyle(color: grey)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
