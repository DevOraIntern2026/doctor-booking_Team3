import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme=ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: GoogleFonts.cairoTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor
        ),
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor
        ),
        headlineSmall: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.blackColor
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGreyColor
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryTextBlackColor
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.blueColor
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.googleButBlackColor
        )
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
        textStyle: GoogleFonts.cairo(
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
          fontSize: 14
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.whiteColor,
      hintStyle: GoogleFonts.cairo(color: AppColors.greyColor,fontWeight: FontWeight.w500,fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.greyColor,width: 1.5)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.greyColor,width: 1.5)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.greyColor,width: 1.5)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.redColor,width: 1.5)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.redColor,width: 1.5)
      ),
      errorStyle: GoogleFonts.cairo(color: AppColors.redColor,fontSize: 13),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      shape: CircleBorder()
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        textStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}