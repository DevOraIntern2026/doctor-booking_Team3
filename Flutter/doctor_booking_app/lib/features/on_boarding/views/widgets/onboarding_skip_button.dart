import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingSkipButton extends StatelessWidget {
  final bool visible;
  final String label;
  final VoidCallback? onPressed;

  const OnboardingSkipButton({
    super.key,
    required this.visible,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Visibility(
            visible: visible,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: TextButton(onPressed: onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparentColor,
                  foregroundColor: AppColors.greyColor,
                  disabledForegroundColor: AppColors.greyColor,
                ),
                child: Text(label)),
          ),
        ),
      ),
    );
  }
}
