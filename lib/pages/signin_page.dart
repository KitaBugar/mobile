import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kitabugar/api/api_service.dart'; // Impor ApiService
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/pages/login_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final String name = _nameController.text;
    final String phone_number = _phoneController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Validasi input
    if (name.isEmpty || phone_number.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${ApiService().baseUrl}/api/user/register'), // Gunakan baseUrl dari ApiService
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'name': name,
          'phone_number': phone_number,
          'email': email,
          'password': password },
      );

      if (response.statusCode == 201) {
        // Jika pendaftaran berhasil, navigasi ke halaman Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Jika pendaftaran gagal, tampilkan pesan kesalahan
        final Map<String, dynamic> responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Pendaftaran gagal')),
        );
      }
    } catch (error) {
      // Tampilkan pesan kesalahan jika terjadi kesalahan jaringan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
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
              Text(
                'Buat Akun',
                style: TextStyles.heading1.copyWith(
                  color: AppPallete.colorTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text('Mulai Petualanganmu Sekarang!',
                  style: TextStyles.body2.copyWith(
                    color: AppPallete.colorTextSecondary,
                  )),
              const SizedBox(height: 32),

              // Nama Field
              Text('Nama',
                  style: TextStyles.body2.copyWith(
                    color: AppPallete.colorTextPrimary,
                  )),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap',
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
              ),
              const SizedBox(height: 16),

              // Nomor Telepon Field
              Text(
                'Nomor Telepon',
                style: TextStyles.body2.copyWith(
                  color: AppPallete.colorTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
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
                initialCountryCode: 'ID',
                onChanged: (phone_number) {
                  print('Nomor Telepon: ${phone_number.completeNumber}');
                },
              ),
              const SizedBox(height: 16),

              // Email Field
              Text('Email',
                  style: TextStyles.body2.copyWith(
                    color: AppPallete.colorTextPrimary,
                  )),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'hello@gmail.com',
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
              const SizedBox(height: 16),

              // Password Field
              Text(
                'Password',
                style: TextStyles.body2.copyWith(
                  color: AppPallete.colorTextPrimary,
                ),
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

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _signUp, // Panggil fungsi pendaftaran
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyles.body1.copyWith(
                      color: AppPallete.colorWhite,
                    ),
                  ),
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
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: AppPallete.colorBorder, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: AppPallete.colorWhite,
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
                      Text(
                        'Continue with Google',
                        style: TextStyles.body1.copyWith(
                          color: AppPallete.colorTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah Punya akun? ',
                    style: TextStyles.body4.copyWith(
                      color: AppPallete.colorTextSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text('Login',
                        style: TextStyles.body4.copyWith(
                          color: AppPallete.colorPrimary,
                        )),
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