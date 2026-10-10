import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/views/screens/forget_password_screen.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/reset_password/views/screens/reset_password_screen.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/verify_otp/views/screens/verify_reset_code_screen.dart';
import 'package:doctor_booking_app/features/auth/login/presentation/views/screens/login_screen.dart';
import 'package:doctor_booking_app/features/auth/register/presentation/views/screens/register_screen.dart';
import 'package:doctor_booking_app/features/home/presentation/views/screens/home_screen.dart';
import 'package:doctor_booking_app/features/on_boarding/views/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings){
    switch(settings.name){
       case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (context) => const OnBoardingScreen(),); 
       case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen(),);
       case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen(),);
       case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPasswordScreen(),settings: settings);
       case AppRoutes.verifyOtp:
        return MaterialPageRoute(builder: (context) => const VerifyResetCodeScreen(),settings: settings); 
       case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (context) => const ResetPasswordScreen(),settings: settings);
       case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);  
       default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}