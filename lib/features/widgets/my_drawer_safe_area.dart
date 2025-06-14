import 'package:flutter/material.dart';
import 'package:voiceofgospel/features/screens/drawer/drawer_page.dart';

class MyDrawerSafeArea extends StatelessWidget {
  const MyDrawerSafeArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const DrawerPage(),
      ),
    );
  }
}
