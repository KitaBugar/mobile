import 'package:kitabugar/pages/member_page.dart';
import 'package:kitabugar/pages/profile_page.dart';
import 'package:kitabugar/pages/ticket_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:kitabugar/pages/onboarding_page.dart';
import 'package:kitabugar/pages/login_page.dart';
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/pages/signin_page.dart';

void main() {
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
      ),
      // theme: AppTheme.lightTheme, // Menggunakan tema dari folder core
      initialRoute: '/', // Route awal
      routes: {
        '/': (context) =>
            const OnboardingPage(), // Halaman pertama (Onboarding)
        '/login': (context) => const LoginPage(),
        '/sign-in': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/member': (context) => const MemberPage(),
        '/profile': (context) => const ProfilePage(),
        '/ticket-detail': (context) => const TicketDetailPage(),
        // '/detail-gym': (context) => const GymDetailPage(),
        // '/gym-details': (context) => GymDetailsPage(), // Rute untuk Detail Gym
        // '/subscribe': (context) =>
        //     SubscribePage(), // Rute untuk Paket Berlangganan
      },
    );
  }
}
