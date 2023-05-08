import 'package:get/get.dart';
import 'package:todo_one/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(Routes.HOME);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
