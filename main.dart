import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_hailing_app/app.dart';
import 'package:ride_hailing_app/core/utils/helpers.dart';
import 'package:ride_hailing_app/data/datasources/local/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await LocalStorage.init();

  // Initialize mock data
  await Helpers.initializeMockData();

  runApp(const RideHailingApp());
}