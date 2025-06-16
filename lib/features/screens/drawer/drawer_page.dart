import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cityMedia/features/data/data_repository.dart';
import 'package:cityMedia/features/screens/drawer/about_us_page.dart';
import 'package:cityMedia/features/screens/drawer/contacts_page.dart';
import 'package:cityMedia/features/screens/drawer/social_widget.dart'; // For launching URLs

class DrawerPage extends ConsumerStatefulWidget {
  const DrawerPage({super.key});

  @override
  ConsumerState<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends ConsumerState<DrawerPage> {
  int currentPageIndex = 0; // 0: Home Page, 1: About Us, 2: Contact

@override
Widget build(BuildContext context) {
      double devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    body: Stack(
      children: [
        // Background radio icon
        Positioned(
          top: devHeight*0.085 ,
          right: -devWidth*0.3, // Adjust this value to control how much of the icon is shown
          child: Transform.rotate(
            angle: -0.5, // Slight rotation in radians
            child: Opacity(
              opacity: 0.6, // 50% opacity
              child: SvgPicture.asset(
                'assets/sidebar_icons/radioIcon.svg',
                height: 300,
                ),
            ),
          ),
        ),
        // Main content
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            const curve = Curves.easeInOut;
            final slideAnimation = Tween<Offset>(
              begin: const Offset(1, 0), // Slide in from right
              end: Offset.zero, // To current position
            ).animate(CurvedAnimation(parent: animation, curve: curve));

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
          child: _getCurrentPage(),
        ),
      ],
    ),
  );
}


  Widget _getCurrentPage() {
    switch (currentPageIndex) {
      case 1:
        return AboutUsPage(onBack: () => setState(() => currentPageIndex = 0));
      case 2:
        return ContactPage(onBack: () => setState(() => currentPageIndex = 0));
      default:
        return _buildMainDrawer();
    }
  }

  Widget _buildMainDrawer() {
    return Container(
      key: const ValueKey(0), // Key for AnimatedSwitcher
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              margin: const EdgeInsets.only(bottom: 25),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/homepage_icons/backIcon.svg',
                  height: 25,
                  color: Colors.grey.shade700,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the sidebar
                },
              ),
            ),
          ),
          _buildSidebarOption(
            title: "Home",
            isSelected: currentPageIndex == 0,
            onTap: () => setState(() => currentPageIndex = 0),
            isIconText: false,
          ),
          _buildSidebarOption(
            title: "About Us",
            isSelected: currentPageIndex == 1,
            onTap: () => setState(() => currentPageIndex = 1),
            isIconText: false,
          ),
          _buildSidebarOption(
            title: "Contacts",
            isSelected: currentPageIndex == 2,
            onTap: () => setState(() => currentPageIndex = 2),
            isIconText: false,
          ),
          // _buildSidebarOption(
          //   title: "94.5 FM",
          //   isSelected: currentPageIndex == 2,
          //   onTap: () => setState(() => currentPageIndex = 2),
          //   isIconText: true,
          // ),
          const Spacer(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildSidebarOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isIconText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        onTap: onTap,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // isIconText? Padding(
            //   padding: const EdgeInsets.fromLTRB(0,0,15,15),
            //   child: SvgPicture.asset('assets/sidebar_icons/radioIcon.svg',height: 40,),
            // ):SizedBox.shrink(),
            Text(
              title,
              style: TextStyle(
                color: isSelected || isIconText
                    ? const Color.fromARGB(255, 40, 104, 135)
                    : const Color.fromARGB(255, 153, 153, 153),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 5),
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: Color.fromARGB(255, 40, 104, 135),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize
            .min,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                ...ref
                .read(getSocialProv)
                .value!
                .map((e) => SocialWidgetButton(socialModel: e)),
            ],
          ),
          const SizedBox(height: 15), 
          GestureDetector(
            onTap: _redirectToStore, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Icon(
                  index < _getAppRating()
                      ? Icons.star 
                      : Icons
                          .star_border, 
                  color: index < _getAppRating()
                      ? const Color.fromARGB(255, 40, 104, 135) 
                      : const Color.fromARGB(255, 153, 153,
                          153), 
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const InkWell(
            child: Text.rich(
              TextSpan(
                text: "Developed by ",
                style: TextStyle(
                  color: Color.fromARGB(255, 153, 153, 153),
                  fontWeight: FontWeight.w100,
                ),
                children: [
                  TextSpan(
                    text: "Lit-Online",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getAppRating() {
    // Placeholder function for fetching app rating. Replace with actual logic
    return 4; // Assume a 4-star rating for now
  }

  void _redirectToStore() {
    final storeUrl = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.lit.cityMedia"
        : "https://apps.apple.com/lb/app/%D8%A5%D8%B0%D8%A7%D8%B9%D8%A9-%D8%B5%D9%88%D8%AA-%D8%A7%D9%84%D8%A5%D9%86%D8%AC%D9%8A%D9%84/id1578779392";
    launchUrl(Uri.parse(storeUrl));
  }
}
