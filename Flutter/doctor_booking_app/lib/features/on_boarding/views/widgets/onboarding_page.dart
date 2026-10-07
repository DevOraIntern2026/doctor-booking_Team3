import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:doctor_booking_app/features/on_boarding/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.42,
            width: double.infinity,
            child: Image.asset(model.image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(model.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
            color: AppColors.greyColor,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),)
        ],
      ),
    );
  }
}
