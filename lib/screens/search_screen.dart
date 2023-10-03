import 'package:all_sm_friends/screens/widget/search_details.dart';
import 'package:all_sm_friends/shared/themes/colors.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/themes/text.dart';
import '../shared/widget/loader.dart';
import 'widget/bottom_NavBar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreServices().searchforcontact(number: phoneNumber),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoaderScreen();
        }
        if (snapshot.hasData) {
          var results = snapshot.data;

          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              leading: BackButton(
                color: orange,
              ),
              title: Text(
                'Search Results',
                style: h5,
              ),
            ),
            body: Padding(
                padding: EdgeInsets.all(16),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SearchDetails(
                      contact: results[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: results!.length,
                  physics: BouncingScrollPhysics(),
                )),
            bottomNavigationBar: BottomNavBar(selectedItemColor: grey),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }
      },
    );
  }
}
