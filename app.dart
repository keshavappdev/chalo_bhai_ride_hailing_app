import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_hailing_app/core/constants/app_theme.dart';
import 'package:ride_hailing_app/core/routes/app_routes.dart';
import 'package:ride_hailing_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:ride_hailing_app/presentation/blocs/driver/driver_bloc.dart';
import 'package:ride_hailing_app/presentation/blocs/ride/ride_bloc.dart';
import 'package:ride_hailing_app/presentation/blocs/user/user_bloc.dart';

class RideHailingApp extends StatelessWidget {
  const RideHailingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => DriverBloc()),
        BlocProvider(create: (_) => RideBloc()),
      ],
      child: MaterialApp.router(
        title: 'Ride Hailing App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}