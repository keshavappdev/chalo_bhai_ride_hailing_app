import 'package:get/get.dart';

import '../../core/services/storage_service.dart';
import '../../data/models/user_role.dart';
import '../../routes/app_routes.dart';
import '../role_selection/role_controller.dart';

class SplashController extends GetxController {
  SplashController(this._storageService, this._roleController);

  final StorageService _storageService;
  final RoleController _roleController;

  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    final role = _storageService.userRole;
    _roleController.selectedRole.value = role;

    if (!_storageService.isLoggedIn || role == null) {
      Get.offAllNamed(AppRoutes.roleSelection);
      return;
    }

    Get.offAllNamed(
      role == UserRole.rider
          ? AppRoutes.riderHome
          : AppRoutes.driverDashboard,
    );
  }
}
