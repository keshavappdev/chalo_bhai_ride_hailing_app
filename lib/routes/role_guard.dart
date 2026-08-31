import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/models/user_role.dart';
import '../features/role_selection/role_controller.dart';
import 'app_routes.dart';

class RoleGuard extends GetMiddleware {
  RoleGuard(this.requiredRole);

  final UserRole requiredRole;

  @override
  RouteSettings? redirect(String? route) {
    final roleController = Get.find<RoleController>();
    if (roleController.selectedRole.value != requiredRole) {
      return const RouteSettings(name: AppRoutes.roleSelection);
    }
    return null;
  }
}
