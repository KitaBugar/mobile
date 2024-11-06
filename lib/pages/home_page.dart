import 'package:flutter/material.dart';
import 'package:kitabugar/home/widgets/hero_widget.dart';
import 'package:kitabugar/home/widgets/last_add_widget.dart';
// import 'package:kitabugar/home/widgets/new_membership_widget.dart';
import 'package:kitabugar/components/buttons/floating_bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

// Fungsi untuk menangani navigasi halaman
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Arahkan ke halaman sesuai dengan indeks
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/member');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      // Tambahkan kasus lain untuk halaman lain jika ada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Hero Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeroWidget(),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // New Membership Section (Uncomment jika diperlukan)
            // SliverToBoxAdapter(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: const [
            //       NewMembershipWidget(),
            //       SizedBox(height: 20),
            //     ],
            //   ),
            // ),

            // Last Add Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  LastAddWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: _currentIndex,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
