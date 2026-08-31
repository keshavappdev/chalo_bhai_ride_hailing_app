import 'package:get/get.dart';

import '../core/api/api_client.dart';
import '../core/services/location_service.dart';
import '../core/services/map_service.dart';
import '../core/services/notification_service.dart';
import '../core/services/storage_service.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/driver_repository.dart';
import '../data/repositories/ride_repository.dart';
import '../features/auth/auth_controller.dart';
import '../features/driver/controllers/driver_controller.dart';
import '../features/rider/controllers/rider_controller.dart';
import '../features/role_selection/role_controller.dart';
import '../features/splash/splash_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiClient>(
      ApiClient(Get.find<StorageService>()),
      permanent: true,
    );
    Get.put<LocationService>(LocationService(), permanent: true);
    Get.put<MapService>(MapService(), permanent: true);
    Get.put<NotificationService>(NotificationService(), permanent: true);
    Get.put<RoleController>(
      RoleController(Get.find<StorageService>()),
      permanent: true,
    );
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(
        Get.find<StorageService>(),
        Get.find<RoleController>(),
      ),
    );
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(Get.find<ApiClient>()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<AuthRepository>(),
        Get.find<StorageService>(),
        Get.find<RoleController>(),
      ),
    );
  }
}

class RiderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideRepository>(
      () => RideRepository(Get.find<ApiClient>(), Get.find<MapService>()),
      fenix: true,
    );
    Get.lazyPut<RiderController>(
      () => RiderController(
        Get.find<RideRepository>(),
        Get.find<LocationService>(),
        Get.find<NotificationService>(),
        Get.find<RoleController>(),
      ),
      fenix: true,
    );
  }
}

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideRepository>(
      () => RideRepository(Get.find<ApiClient>(), Get.find<MapService>()),
      fenix: true,
    );
    Get.lazyPut<DriverRepository>(
      () => DriverRepository(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<DriverController>(
      () => DriverController(
        Get.find<DriverRepository>(),
        Get.find<RideRepository>(),
        Get.find<LocationService>(),
        Get.find<NotificationService>(),
        Get.find<RoleController>(),
      ),
      fenix: true,
    );
  }
}
