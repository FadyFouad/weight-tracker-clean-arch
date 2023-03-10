import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/core/app_colors.dart';

class AppTheme {
  static get lightTheme => ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.grey.withOpacity(0.2),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
        ),
        iconTheme: IconThemeData(color: AppColors.grey),
        scaffoldBackgroundColor: AppColors.offWhite,
        primarySwatch: Colors.blue,
      );
}
