import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voiceofgospel/features/data/data_repository.dart';
import 'package:voiceofgospel/features/widgets/home_widgets/home_player_reload.dart';
import 'package:voiceofgospel/theme/colors.dart';

class HomeHeader extends ConsumerWidget implements PreferredSizeWidget {
  final double height;

  const HomeHeader({super.key, required this.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationLogoUrl = ref.watch(getStationProv).value?.urlHeaderLogo ?? '';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: CachedNetworkImage(
          height: 35,
          imageUrl: stationLogoUrl,
        ),
        // title: Image.asset(
        //   'assets/logo/smallLogo.png', // Replace with your logo's file path in the assets folder
        //   height: 50, // Adjust the height as needed
        //   fit: BoxFit.contain,
        // ),
        // title: const Text(
        //   'VOG',
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        // ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/homepage_icons/sidebarIcon.svg', // Replace with your SVG file path
              color: AppColors.iconsColorActive, // Optional: apply color to the SVG
              height: 20, // Adjust height as needed
            ),
          ),
        ),
        actions: const [HomePlayerReload()],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
