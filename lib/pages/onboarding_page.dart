import 'package:kitabugar/pages/login_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.colorBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              // Main Illustration
              Center(
                child: Image.asset(
                  'assets/images/Onboarding_Image.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              const SizedBox(height: 30),
              // Welcome Text
              Text(
                'Selamat Datang di KitaBugar',
                style: TextStyles.body2
                    .copyWith(color: AppPallete.colorTextSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Description Text
              Text(
                'Pilih paket Membership yang kamu suka & nikmati akses instan ke gym favoritmu!',
                style: TextStyles.body1
                    .copyWith(color: AppPallete.colorTextPrimary),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Get Started',
                    style:
                        TextStyles.body1.copyWith(color: AppPallete.colorWhite),
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
