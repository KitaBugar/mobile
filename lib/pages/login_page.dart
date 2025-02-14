import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kitabugar/components/buttons/primary_button.dart';
import 'package:kitabugar/config/navigation_helper.dart';
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/pages/signin_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

const String apiUrl =
    'https://4be4-180-241-240-149.ngrok-free.app/api/user/login';

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

  Future<void> _login() async {
    final String baseUrl =
        dotenv.env['BASE_URL'] ?? ''; // Ambil BASE_URL dari .env
    final String apiUrl =
        '$baseUrl/api/user/login'; // Gunakan BASE_URL untuk API

    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Validasi input
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email dan Password tidak boleh kosong')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // log("RESPONSE => ${response.body}");
        // Jika login berhasil, simpan token
        final Map<String, dynamic> responseData = json.decode(response.body);
        log("RESPONSE => ${responseData['items']}");
        String token =
            responseData["items"]['token']; // Pastikan API mengembalikan token
        // Simpan token ke SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        // Navigasi ke halaman Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(responseData['message'] ?? 'Email atau Password salah')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
      log("ERROR => $error");
    }
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
                          color: AppPallete.colorWhite,
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
                  onPressed: _login, // Panggil fungsi login
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppPallete.colorPrimary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
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
                    side: MaterialStateProperty.all(
                      const BorderSide(color: AppPallete.colorBorder, width: 1),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppPallete.colorWhite),
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
