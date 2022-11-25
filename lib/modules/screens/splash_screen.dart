import 'dart:async';

import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/utils/app_strings.dart';
import 'package:e_commerce_flutter/core/utils/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/routes/app_routers.dart';
import '../../core/services/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  _startTimer() {
    var user = CacheHelper.getData(key: 'user');
    print("is user logged in🙂: $user");
    print("is admin logged in🐺: ${CacheHelper.getData(key: 'admin')}");
    String starScreen =
        user != '' && user != null ? Routers.LAYOUT_SCREEN : Routers.LOGIN;
    timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        starScreen,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.4,
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(AppImage.splashImage),
                ),
              ),
            ),
            AppSize.sv_80,
            Text(
              'مليون أخ',
              style: GoogleFonts.almarai(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
