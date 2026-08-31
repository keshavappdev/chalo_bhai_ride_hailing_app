import 'package:get/get.dart';

import '../../core/services/storage_service.dart';
import '../../data/models/user_role.dart';
import '../../routes/app_routes.dart';

class RoleController extends GetxController {
  RoleController(this._storageService);

  final StorageService _storageService;
  final selectedRole = Rxn<UserRole>();

  @override
  void onInit() {
    selectedRole.value = _storageService.userRole;
    super.onInit();
  }

  Future<void> selectRole(UserRole role) async {
    selectedRole.value = role;
    await _storageService.saveUserRole(role);
  }

  Future<void> continueAs(UserRole role) async {
    await selectRole(role);
    Get.toNamed(AppRoutes.login);
  }

  Future<void> logout() async {
    await _storageService.clearSession();
    selectedRole.value = null;
    Get.offAllNamed(AppRoutes.roleSelection);
  }
}
