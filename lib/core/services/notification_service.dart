import 'package:get/get.dart';

class NotificationService extends GetxService {
  Future<NotificationService> init() async {
    // TODO: Register local notification channels when notifications are added.
    return this;
  }

  void showInAppMessage(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.TOP);
  }
}
