import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:radio/source/constants/images.dart';
import 'package:cityMedia/theme/images.dart';
import 'package:cityMedia/features/data/data_repository.dart';

class HomeBackgroundContainer extends ConsumerWidget {
  const HomeBackgroundContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_image/image5.png'),
          // image: CachedNetworkImageProvider(ref.read(getStationProv).value!.urlHomeBackGround),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
