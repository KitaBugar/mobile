import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kitabugar/config/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kitabugar/pages/member_page.dart';
import 'package:kitabugar/pages/profile_page.dart';
import 'package:kitabugar/pages/ticket_detail_page.dart';
import 'package:kitabugar/pages/onboarding_page.dart'; // Pastikan ini diimpor
import 'package:kitabugar/pages/login_page.dart';
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/pages/signin_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan Flutter binding terinisialisasi
  await dotenv.load(); // Load .env sebelum menjalankan aplikasi
  storage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue, // Tambahkan warna utama
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // Agar UI lebih baik di semua perangkat
      ),
      initialRoute: '/', // Route awal ke SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/sign-in': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/member': (context) => const MemberPage(),
        '/profile': (context) => const ProfilePage(),
        '/ticket-detail': (context) => const TicketDetailPage(),
        '/onboarding': (context) =>
            const OnboardingPage(), // Tambahkan rute untuk OnboardingPage
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi loading

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        token != null
            ? '/home'
            : '/onboarding', // Gunakan route sesuai kondisi login
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(), // Loading indicator
      ),
    );
  }
}
