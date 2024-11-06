import 'package:kitabugar/components/buttons/primary_button.dart';
import 'package:kitabugar/config/navigation_helper.dart';
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/pages/signin_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.colorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header
              Text(
                'Masuk',
                style: TextStyles.heading1.copyWith(
                  color: AppPallete.colorTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Mulai Petualanganmu Sekarang!',
                style: TextStyles.body2.copyWith(
                  color: AppPallete.colorTextSecondary,
                ),
              ),
              const SizedBox(height: 40),

              // Email Field
              Text('Email',
                  style: TextStyles.body2.copyWith(
                    color: AppPallete.colorTextPrimary,
                  )),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'hello@example.com',
                  hintStyle: TextStyles.body2.copyWith(
                    color: AppPallete.colorTextSecondary,
                  ),
                  filled: true,
                  fillColor: AppPallete.colorForm,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Password Field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Password',
                      style: TextStyles.body2.copyWith(
                        color: AppPallete.colorTextPrimary,
                      )),
                  GestureDetector(
                    onTap: () {
                      // Handle Lupa Password
                    },
                    child: Text('Lupa Password?',
                        style: TextStyles.body2.copyWith(
                          color: AppPallete.colorPrimary,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: '********',
                  hintStyle: TextStyles.body2.copyWith(
                    color: AppPallete.colorTextSecondary,
                  ),
                  filled: true,
                  fillColor: AppPallete.colorForm,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppPallete.colorTextSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Login
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppPallete.colorPrimary),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: Text('Login',
                      style: TextStyles.body1.copyWith(
                        color: AppPallete.colorWhite,
                      )),
                ),
              ),
              const SizedBox(height: 16),

              // Google Sign In Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Google Sign In
                  },
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(
                      const BorderSide(color: AppPallete.colorBorder, width: 1),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    backgroundColor:
                        WidgetStateProperty.all(AppPallete.colorWhite),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Google.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      Text('Continue with Google',
                          style: TextStyles.body1.copyWith(
                            color: AppPallete.colorTextSecondary,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum Punya akun? ',
                    style: TextStyle(
                      color: AppPallete.colorTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                  PrimaryButton(
                    title: "Sign Up",
                    onTap: () {
                      // Navigasi ke halaman signin
                      NavigationHelper.nextScreen(
                        context,
                        const SignInPage(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
