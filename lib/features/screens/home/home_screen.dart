import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cityMedia/features/data/data_repository.dart';
import 'package:cityMedia/features/widgets/home_widgets/home_background_container.dart';
import 'package:cityMedia/features/widgets/home_widgets/home_mid_container.dart';
import 'package:cityMedia/features/widgets/home_widgets/home_shade_container.dart';
import 'package:cityMedia/features/widgets/home_widgets/home_header.dart';
import 'package:cityMedia/features/widgets/my_drawer_safe_area.dart';
import 'package:cityMedia/theme/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {


  getData() async {
    print('I am in ASYNNNCCCCCCCC');
    await Future.wait([
      ref.read(getSocialProv.future),
      ref.read(getShareProv.future),
      ref.read(getStationProv.future),
    ]);
    if (mounted) {
      setState(() {
        print('I am in set stateeeeeeeeeeeeeeeee');
      });
    }
  }

  @override
  void initState() {
    getData();

    print('I am in set REAAADDDDYYYYYYYY');

    super.initState();
  }

  Future<bool?> _showBackDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure?',
            style: TextStyle(color: AppColors.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Are you sure you want to leave this app?',
            style: TextStyle(color: AppColors.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text(
                    'Minimize',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.of(context).pop(false);
                    // moveToBackground();
                    // sleep(Duration(days: 1));
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text(
                    'Leave',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    exit(0);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        bool? confirmExit = await _showBackDialog();
        if (confirmExit != null && confirmExit) {
          exit(0);
        } else if (confirmExit != null && confirmExit == false) {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const MyDrawerSafeArea(),
        body: Stack(
          children: [
            const HomeBackgroundContainer(),
            const HomeShadeContainer(),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 2, child: HomeHeader(height: devHeight)),
                  const Expanded(flex: 9, child: HomeMidContainer()),
                  // const Expanded(
                  //   flex: 1,
                  //   child: SizedBox(),
                  // )
                  // Consumer(builder: (context, ref, _) {
                  //   return Text(
                  //     ref.read(getStationProv).value!.slug,
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: 15,
                  //       color: AppColors.textSecondaryColor,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   );
                  // }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
