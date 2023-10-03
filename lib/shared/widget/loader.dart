import 'package:all_sm_friends/shared/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../screens/widget/bottom_NavBar.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: white,
      ),
    );
  }
}

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Loader()),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
