import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'bindings/app_bindings.dart';
import 'core/constants/app_constants.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // The example file keeps the portfolio app runnable without secrets.
  // For real APIs, copy .env.example to .env and load that file instead.
  await dotenv.load(fileName: '.env.example');
  final storage = await StorageService().init();
  Get.put<StorageService>(storage, permanent: true);

  runApp(const ChaloBhaiApp());
}

class ChaloBhaiApp extends StatelessWidget {
  const ChaloBhaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 280),
    );
  }
}
