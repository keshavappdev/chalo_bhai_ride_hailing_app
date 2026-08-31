import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/storage_service.dart';
import '../../data/models/user_role.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';
import '../role_selection/role_controller.dart';

class AuthController extends GetxController {
  AuthController(
    this._repository,
    this._storageService,
    this._roleController,
  );

  final AuthRepository _repository;
  final StorageService _storageService;
  final RoleController _roleController;

  final emailController = TextEditingController(text: 'demo@chalobhai.app');
  final passwordController = TextEditingController(text: 'password');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final obscurePassword = true.obs;

  UserRole get role => _roleController.selectedRole.value ?? UserRole.rider;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      errorMessage.value = 'Enter your email and password.';
      return;
    }
    await _authenticate(isRegister: false);
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        passwordController.text.length < 6) {
      errorMessage.value = 'Complete all fields. Password must be 6+ characters.';
      return;
    }
    await _authenticate(isRegister: true);
  }

  Future<void> _authenticate({required bool isRegister}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final session = isRegister
          ? await _repository.register(
              role: role,
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneController.text.trim(),
              password: passwordController.text,
            )
          : await _repository.login(
              role: role,
              email: emailController.text.trim(),
              password: passwordController.text,
            );
      await _storageService.saveSession(
        token: session.token,
        userId: session.userId,
        role: role,
      );
      Get.offAllNamed(
        role == UserRole.rider
            ? AppRoutes.riderHome
            : AppRoutes.driverDashboard,
      );
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
