import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_app/core/resources/app_colors.dart';

/// Reads onboarding/session state and replaces the splash route with the next
/// screen. Connect these callbacks to the app's preferences and auth services.
class SplashScreen extends StatefulWidget {
	const SplashScreen({
		super.key,
		required this.isFirstTime,
		required this.isLoggedIn,

	});

	final bool isFirstTime;
	final bool isLoggedIn;
	final String onboarding = AppRoutes.onBoarding;
	final String home = AppRoutes.home;
	final String login = AppRoutes.login;

	@override
	State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
	@override
	void initState() {
		super.initState();
		_resolveNextScreen();
	}

	Future<void> _resolveNextScreen() async {
		await Future<void>.delayed(const Duration(seconds: 60));

		String destination;
		if (widget.isFirstTime) {
			destination = widget.onboarding;
		} else if (widget.isLoggedIn) {
			destination = widget.home;
		} else {
			destination = widget.login;
		}

		if (!mounted) return;
		Navigator.of(context).pushReplacementNamed(destination);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SizedBox.expand(
				child: DecoratedBox(
					decoration: const BoxDecoration(
						gradient: LinearGradient(
							begin: Alignment.topLeft,
							end: Alignment.bottomRight,
							colors: [AppColors.onboardingBackgroundStart,
                       AppColors.onboardingBackgroundMiddle,
                       AppColors.onboardingBackgroundEnd
                       ],
							stops: [0, 0.5, 1],
						),
					),
					child: CustomPaint(
						child: Center(
							child: Image.asset(
								AppImages.appLogoWithSlogan,
								width: 300,
								height: 300,
								fit: BoxFit.contain,
								errorBuilder: (_, __, ___) => const Icon(
									Icons.medical_services_rounded,
									size: 112,
									color: AppColors.onboardingBlue,
								),
							),
						),
					),
				),
			),
		);
	}
}

