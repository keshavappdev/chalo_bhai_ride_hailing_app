import 'package:get/get.dart';

import '../bindings/app_bindings.dart';
import '../data/models/user_role.dart';
import '../features/auth/login_view.dart';
import '../features/auth/register_view.dart';
import '../features/driver/views/active_trip_view.dart';
import '../features/driver/views/driver_dashboard_view.dart';
import '../features/driver/views/driver_earnings_view.dart';
import '../features/driver/views/driver_history_view.dart';
import '../features/driver/views/driver_profile_view.dart';
import '../features/driver/views/ride_requests_view.dart';
import '../features/rider/views/live_ride_view.dart';
import '../features/rider/views/location_search_view.dart';
import '../features/rider/views/ride_estimate_view.dart';
import '../features/rider/views/rider_history_view.dart';
import '../features/rider/views/rider_home_view.dart';
import '../features/rider/views/rider_profile_view.dart';
import '../features/rider/views/searching_driver_view.dart';
import '../features/role_selection/role_selection_view.dart';
import '../features/splash/splash_view.dart';
import 'app_routes.dart';
import 'role_guard.dart';

abstract final class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.roleSelection,
      page: () => const RoleSelectionView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.riderHome,
      page: () => const RiderHomeView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),
    GetPage(
      name: AppRoutes.riderLocationSearch,
      page: () => const LocationSearchView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),
    GetPage(
      name: AppRoutes.riderRideEstimate,
      page: () => const RideEstimateView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),
    GetPage(
      name: AppRoutes.riderSearchingDriver,
      page: () => const SearchingDriverView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),
    GetPage(
      name: AppRoutes.riderLiveRide,
      page: () => const LiveRideView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),
    GetPage(
      name: AppRoutes.riderHistory,
      page: () => const RiderHistoryView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),
    GetPage(
      name: AppRoutes.riderProfile,
      page: () => const RiderProfileView(),
      binding: RiderBinding(),
      middlewares: [RoleGuard(UserRole.rider)],
    ),

    GetPage(
      name: AppRoutes.driverDashboard,
      page: () => const DriverDashboardView(),
      binding: DriverBinding(),
      middlewares: [RoleGuard(UserRole.driver)],
    ),
    GetPage(
      name: AppRoutes.driverRideRequests,
      page: () => const RideRequestsView(),
      binding: DriverBinding(),
      middlewares: [RoleGuard(UserRole.driver)],
    ),
    GetPage(
      name: AppRoutes.driverActiveTrip,
      page: () => const ActiveTripView(),
      binding: DriverBinding(),
      middlewares: [RoleGuard(UserRole.driver)],
    ),
    GetPage(
      name: AppRoutes.driverEarnings,
      page: () => const DriverEarningsView(),
      binding: DriverBinding(),
      middlewares: [RoleGuard(UserRole.driver)],
    ),
    GetPage(
      name: AppRoutes.driverHistory,
      page: () => const DriverHistoryView(),
      binding: DriverBinding(),
      middlewares: [RoleGuard(UserRole.driver)],
    ),
    GetPage(
      name: AppRoutes.driverProfile,
      page: () => const DriverProfileView(),
      binding: DriverBinding(),
      middlewares: [RoleGuard(UserRole.driver)],
    ),
  ];
}
