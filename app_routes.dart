import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_hailing_app/presentation/screens/driver/auth/driver_login_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/dashboard/driver_dashboard_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/earnings/earnings_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/history/driver_ride_history_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/profile/driver_profile_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/rides/current_ride_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/rides/navigation_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/rides/ride_request_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/auth/login_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/auth/signup_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/history/ride_history_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/home/home_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/notifications/notifications_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/profile/user_profile_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/ride/booking_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/ride/driver_assigned_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/ride/driver_searching_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/ride/fare_estimation_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/ride/ride_tracking_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/ride/vehicle_selection_screen.dart';
import 'package:ride_hailing_app/presentation/screens/user/settings/settings_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/settings/driver_settings_screen.dart';
import 'package:ride_hailing_app/presentation/screens/driver/notifications/driver_notifications_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String booking = '/booking';
  static const String vehicleSelection = '/vehicle-selection';
  static const String fareEstimation = '/fare-estimation';
  static const String driverSearching = '/driver-searching';
  static const String driverAssigned = '/driver-assigned';
  static const String rideTracking = '/ride-tracking';
  static const String rideHistory = '/ride-history';
  static const String userProfile = '/user-profile';
  static const String userNotifications = '/user-notifications';
  static const String userSettings = '/user-settings';

  static const String driverLogin = '/driver-login';
  static const String driverDashboard = '/driver-dashboard';
  static const String rideRequest = '/ride-request';
  static const String currentRide = '/current-ride';
  static const String navigation = '/navigation';
  static const String driverEarnings = '/driver-earnings';
  static const String driverRideHistory = '/driver-ride-history';
  static const String driverProfile = '/driver-profile';
  static const String driverNotifications = '/driver-notifications';
  static const String driverSettings = '/driver-settings';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      // User Routes
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: booking,
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: vehicleSelection,
        builder: (context, state) => const VehicleSelectionScreen(),
      ),
      GoRoute(
        path: fareEstimation,
        builder: (context, state) => const FareEstimationScreen(),
      ),
      GoRoute(
        path: driverSearching,
        builder: (context, state) => const DriverSearchingScreen(),
      ),
      GoRoute(
        path: driverAssigned,
        builder: (context, state) => const DriverAssignedScreen(),
      ),
      GoRoute(
        path: rideTracking,
        builder: (context, state) => const RideTrackingScreen(),
      ),
      GoRoute(
        path: rideHistory,
        builder: (context, state) => const RideHistoryScreen(),
      ),
      GoRoute(
        path: userProfile,
        builder: (context, state) => const UserProfileScreen(),
      ),
      GoRoute(
        path: userNotifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: userSettings,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Driver Routes
      GoRoute(
        path: driverLogin,
        builder: (context, state) => const DriverLoginScreen(),
      ),
      GoRoute(
        path: driverDashboard,
        builder: (context, state) => const DriverDashboardScreen(),
      ),
      GoRoute(
        path: rideRequest,
        builder: (context, state) => const RideRequestScreen(),
      ),
      GoRoute(
        path: currentRide,
        builder: (context, state) => const CurrentRideScreen(),
      ),
      GoRoute(
        path: navigation,
        builder: (context, state) => const NavigationScreen(),
      ),
      GoRoute(
        path: driverEarnings,
        builder: (context, state) => const EarningsScreen(),
      ),
      GoRoute(
        path: driverRideHistory,
        builder: (context, state) => const DriverRideHistoryScreen(),
      ),
      GoRoute(
        path: driverProfile,
        builder: (context, state) => const DriverProfileScreen(),
      ),
      GoRoute(
        path: driverNotifications,
        builder: (context, state) => const DriverNotificationsScreen(),
      ),
      GoRoute(
        path: driverSettings,
        builder: (context, state) => const DriverSettingsScreen(),
      ),
    ],
  );
}