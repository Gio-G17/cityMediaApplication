import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cityMedia/features/data/data_repository.dart';
import 'package:cityMedia/features/widgets/home_widgets/home_player_reload.dart';
import 'package:cityMedia/theme/colors.dart';

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
        title: const Text(
          'City Media',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/homepage_icons/sidebarIcon.svg',
              color: AppColors.iconsColorActive,
              height: 20,
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
