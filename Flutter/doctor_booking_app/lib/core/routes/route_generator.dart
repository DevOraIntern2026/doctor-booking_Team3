import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/features/on_boarding/views/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings){
    switch(settings.name){
       case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (context) => const OnBoardingScreen(),);  
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