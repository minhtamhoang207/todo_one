import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_one/app/config/assets.gen.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.images.imgSplash.path,
          width: 100,
          height: 76,
        )
      ),
    );
  }
}
