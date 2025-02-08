import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabugar/api/api_service.dart';
import 'package:kitabugar/components/buttons/floating_bottom_navbar.dart';
import 'package:kitabugar/pages/gym_detail_page.dart'; // Pastikan untuk mengimpor halaman GymDetailsPage
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<dynamic> _gyms = [];
  bool _isLoading = true;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await apiService.getGyms();
      if (!mounted) return;
      setState(() {
        _gyms = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroWidget(),
                        const Gap(20),
                        _buildLastAddedWidget(),
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

  Widget _buildHeroWidget() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/backgrounds/HeaderIllustration.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 54,
                    top: 44,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 44),
                      Center(
                        child: Text(
                          "Prioritize Your Health",
                          style: TextStyles.heading3.copyWith(
                            color: AppPallete.colorWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLastAddedWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terakhir Ditambahkan',
            style: TextStyles.body1.copyWith(
              color: AppPallete.colorTextPrimary,
            ),
          ),
          const SizedBox(height: 12),
          // Looping gym cards with spacing
          ..._gyms.map((gym) {
            return Column(
              children: [
                _buildGymCard(gym),
                const SizedBox(height: 14), // Jarak antar kartu
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGymCard(dynamic gym) {
    String name = gym['name'] ?? 'No Name';
    String location = gym['address'] ?? 'No Address';
    String imageUrl = gym['image'] != null && gym['image'].isNotEmpty
        ? gym['image'][0]['image_url']
        : 'https://via.placeholder.com/200'; // Placeholder image
    String description = gym['description'] ?? 'No Description';
    String operatingHours = gym['operating_hours'] ?? 'N/A';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GymDetailPage(
          gymName: name,
          description: description,
          imageUrl: imageUrl,
          operatingHours: operatingHours,
          address: location,
          gymId: gym['id'], // Pastikan untuk mengirim gymId di sini
        ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.body2.copyWith(
                      color: AppPallete.colorTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyles.body3.copyWith(
                          color: AppPallete.colorTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fasilitas',
                        style: TextStyles.body4.copyWith(
                          color: AppPallete.colorTextPrimary,
                        ),
                      ),
                      Text(
                        'Lihat semua',
                        style: TextStyles.body5.copyWith(
                          color: AppPallete.colorPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppPallete.colorPrimary,
                        child: Icon(Icons.access_time, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Opening',
                            style: TextStyles.body4.copyWith(
                              color: AppPallete.colorTextPrimary,
                            ),
                          ),
                          Text(
                            operatingHours,
                            style: TextStyles.body5.copyWith(
                              color: AppPallete.colorTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}