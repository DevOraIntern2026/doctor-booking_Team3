import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/features/on_boarding/data/models/onboarding_model.dart';
import 'package:doctor_booking_app/features/on_boarding/views/widgets/onboarding_page.dart';
import 'package:doctor_booking_app/features/on_boarding/views/widgets/onboarding_skip_button.dart';
import 'package:doctor_booking_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _finishOnboarding() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final pages = [
      OnboardingModel(
        image: AppAssets.onboarding1,
        title: localization.onboarding_title_1,
        description: localization.onboarding_description_1,
      ),
      OnboardingModel(
        image: AppAssets.onboarding2,
        title: localization.onboarding_title_2,
        description: localization.onboarding_description_2,
      ),
      OnboardingModel(
        image: AppAssets.onboarding3,
        title: localization.onboarding_title_3,
        description: localization.onboarding_description_3,
      ),
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.onboardingBackgroundStart,
              AppColors.onboardingBackgroundMiddle,
              AppColors.onboardingBackgroundEnd,
            ],
            stops: [0, 0.5, 1],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// -- Skip Button
              OnboardingSkipButton(
                visible: _currentPage > 0,
                label: localization.onboarding_skip,
                onPressed: _finishOnboarding,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPage(model: pages[index]);
                  },
                ),
              ),

              /// -- 3 dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: List.generate(pages.length, (index) {
                  final isActive = index == _currentPage;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 8,
                    width: isActive ? 32 : 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.onboardingBlue
                          : AppColors.onboardingInactiveIndicator,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.onboardingBlue,
                      foregroundColor: AppColors.whiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_currentPage < pages.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }else{
                        _finishOnboarding();
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(localization.onboarding_next),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right, size: 20, textDirection: TextDirection.ltr,),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
